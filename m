Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF4B278C9F
	for <lists+linux-pm@lfdr.de>; Fri, 25 Sep 2020 17:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgIYP1h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 11:27:37 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42113 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbgIYP1h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2020 11:27:37 -0400
Received: by mail-ot1-f66.google.com with SMTP id m13so2629745otl.9
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2020 08:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hYZFtXCYjTrRnkRERS3aRwjVpSpqk7/94nKF01x+sB8=;
        b=sSr9rsSiKzSWYwO8hrM/Sp4AolQmkWp+z0nqbpW/kXwYTXWEuD4xzBfxe4D1zZzhfY
         tXCCR6icJBVjqCI/slWYWQA8f7SJyQB1t5D19y0d3a7JdkZKuAK/XEbCDLGYFXnN17Wj
         mHP+qQ1TIRZ7+eSyo0ifojEM4XolP3p9VO3OK198P2amdFS17Cf76836hryXFcn5GIWZ
         4yAzxf8sRzcEJBRSp/CR2bbzihPXwqMNONNVIqGmA/BlFBNru2gU9zF6HxOLhAHqkCcq
         QHnrOFrEKQjETOHQ8URjKX73G8k2OaYB718UGGx7QNOi+u7+xh//UgXjZwmt3U5ZlvpW
         WNzQ==
X-Gm-Message-State: AOAM532zToMmHpScZZwlwUFMSR0+9erDgLrvcpXNkcbRYHEOI+kHYmGB
        PcGfNDJSlG3Rp4PUmHst5hfH5/B9Su9ADO4ZngN4a8fk
X-Google-Smtp-Source: ABdhPJwTT4rE/Gh3E+kHmMrA1aHLGIGWuzm3IIpqhgVqgtls+2eFSGozPocYXzloTag5JCj3bRXVRL5fC84qcuvnYXg=
X-Received: by 2002:a05:6830:1f16:: with SMTP id u22mr666864otg.118.1601047656398;
 Fri, 25 Sep 2020 08:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <cc09f36e506145399fe470c71ad34c7c@EX13D12UWA002.ant.amazon.com>
In-Reply-To: <cc09f36e506145399fe470c71ad34c7c@EX13D12UWA002.ant.amazon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Sep 2020 17:27:25 +0200
Message-ID: <CAJZ5v0h-qmKcwis9GSa=ceBUMgkvq1s3XqchPotM_DH2=in6qA@mail.gmail.com>
Subject: Re: [PATCH] PM: Batch hibernate and resume IO requests
To:     "Chen, Xiaoyi" <cxiaoyi@amazon.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Agarwal, Anchal" <anchalag@amazon.com>,
        "Duncan, David" <davdunc@amazon.com>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "esandeen@redhat.com" <esandeen@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 22, 2020 at 6:19 PM Chen, Xiaoyi <cxiaoyi@amazon.com> wrote:
>
>
> Hibernate and resume process submits individual IO requests for each page
> of the data. With this patch, we use blk_plug to improve the batching of
> these requests.
>
> Tested this patch with hibernate and resumes, and consistently observed the
> merging of the IO requests. We see more than an order of magnitude
> improvement in hibernate and resume speed.
>
> One hibernate and resume cycle for 16GB used RAM out of 32GB takes around
> 21 minutes before the change, and 1 minutes after the change on systems
> with limited storage IOPS.
>
> Signed-off-by: Xiaoyi Chen <cxiaoyi@amazon.com>
> Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
> ---
>  kernel/power/swap.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 01e2858b5fe3..961615365b5c 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -226,6 +226,7 @@ struct hib_bio_batch {
>         atomic_t                count;
>         wait_queue_head_t       wait;
>         blk_status_t            error;
> +       struct blk_plug         plug;
>  };
>
>  static void hib_init_batch(struct hib_bio_batch *hb)
> @@ -233,6 +234,12 @@ static void hib_init_batch(struct hib_bio_batch *hb)
>         atomic_set(&hb->count, 0);
>         init_waitqueue_head(&hb->wait);
>         hb->error = BLK_STS_OK;
> +       blk_start_plug(&hb->plug);
> +}
> +
> +static void hib_finish_batch(struct hib_bio_batch *hb)
> +{
> +       blk_finish_plug(&hb->plug);
>  }
>
>  static void hib_end_io(struct bio *bio)
> @@ -294,6 +301,10 @@ static int hib_submit_io(int op, int op_flags, pgoff_t page_off, void *addr,
>
>  static blk_status_t hib_wait_io(struct hib_bio_batch *hb)
>  {
> +       /*
> +        * We are relying on the behavior of blk_plug that a thread with
> +        * a plug will flush the plug list before sleeping.
> +        */
>         wait_event(hb->wait, atomic_read(&hb->count) == 0);
>         return blk_status_to_errno(hb->error);
>  }
> @@ -561,6 +572,7 @@ static int save_image(struct swap_map_handle *handle,
>                 nr_pages++;
>         }
>         err2 = hib_wait_io(&hb);
> +       hib_finish_batch(&hb);
>         stop = ktime_get();
>         if (!ret)
>                 ret = err2;
> @@ -854,6 +866,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
>                 pr_info("Image saving done\n");
>         swsusp_show_speed(start, stop, nr_to_write, "Wrote");
>  out_clean:
> +       hib_finish_batch(&hb);
>         if (crc) {
>                 if (crc->thr)
>                         kthread_stop(crc->thr);
> @@ -1084,6 +1097,7 @@ static int load_image(struct swap_map_handle *handle,
>                 nr_pages++;
>         }
>         err2 = hib_wait_io(&hb);
> +       hib_finish_batch(&hb);
>         stop = ktime_get();
>         if (!ret)
>                 ret = err2;
> @@ -1447,6 +1461,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
>         }
>         swsusp_show_speed(start, stop, nr_to_read, "Read");
>  out_clean:
> +       hib_finish_batch(&hb);
>         for (i = 0; i < ring_size; i++)
>                 free_page((unsigned long)page[i]);
>         if (crc) {
> --

Applied as 5.10 material with some subject and changelog edits, but:
1. The patch is white-space-damaged and I needed to fix that up
manually which was not fun.
2. I dropped the second S-o-b, because it was not clear to me whether
a Co-developed-by tag was missing or Reviewed-by should have been used
instead.

Thanks!
