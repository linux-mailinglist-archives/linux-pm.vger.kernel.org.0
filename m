Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD176D67DA
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2019 18:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388319AbfJNQ7B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Oct 2019 12:59:01 -0400
Received: from foss.arm.com ([217.140.110.172]:49128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfJNQ7A (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Oct 2019 12:59:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9300E28;
        Mon, 14 Oct 2019 09:59:00 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E22063F718;
        Mon, 14 Oct 2019 09:58:59 -0700 (PDT)
Date:   Mon, 14 Oct 2019 17:58:51 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sujeet Kumar Baranwal <sbaranwal@marvell.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [EXT] Re: SCMI & Devfreq
Message-ID: <20191014165832.GA323@bogus>
References: <BYAPR18MB24387C9DDE32067F1763B6DEAFB00@BYAPR18MB2438.namprd18.prod.outlook.com>
 <20190913102304.GC2559@bogus>
 <BYAPR18MB2438723658EF1F0586170CDDAF8C0@BYAPR18MB2438.namprd18.prod.outlook.com>
 <20190916101505.GB6109@bogus>
 <BYAPR18MB2438DC4E8CA4E90455F0345BAF8C0@BYAPR18MB2438.namprd18.prod.outlook.com>
 <BYAPR18MB2438047B622951C6EFE92FABAF8E0@BYAPR18MB2438.namprd18.prod.outlook.com>
 <20190919152300.GA11801@bogus>
 <BYAPR18MB2438ADA20039CFF8F62DFF11AF9B0@BYAPR18MB2438.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR18MB2438ADA20039CFF8F62DFF11AF9B0@BYAPR18MB2438.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 07, 2019 at 06:20:40PM +0000, Sujeet Kumar Baranwal wrote:
> Hi Sudeep,
>
> Per SCMI perf protocol, the MAX_OPPS macro which is 16, means that at max
> there could be only 16 OPPs. In my platform implementation, I tried with 16
> OPPs but  when OPPs info came linux perf.c file from SCP, it only showed 12
> OPPs only.
>
> Suspecting the rx buffer size, I increased the size to 256 and now the
> message for all 16 OPPs were reliably received.
>

OK, but is there any reason why firmware can't use num_levels[31:16]
i.e Number of remaining performance levels and [11:00] i.e.Number of
performance levels that are returned by this call to break and send in
2 calls ? The interface was designed to work with minimum shmem size.


> *****************
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 449f713..737d675 100644 (file)
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -612,7 +612,7 @@ int scmi_handle_put(const struct scmi_handle *handle)
>  static const struct scmi_desc scmi_generic_desc = {
>         .max_rx_timeout_ms = 30,        /* We may increase this if required */
>         .max_msg = 20,          /* Limited by MBOX_TX_QUEUE_LEN */
> -       .max_msg_size = 128,
> +       .max_msg_size = 256,

If you need this, I prefer to introduce new compatible for the platform
scmi and add it as platform specific scmi_desc to start with.

--
Regards,
Sudeep
