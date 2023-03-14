Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393D26B9D95
	for <lists+linux-pm@lfdr.de>; Tue, 14 Mar 2023 18:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjCNRy0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 14 Mar 2023 13:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCNRyY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Mar 2023 13:54:24 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0F5CA3F
        for <linux-pm@vger.kernel.org>; Tue, 14 Mar 2023 10:54:04 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id fd5so31518091edb.7
        for <linux-pm@vger.kernel.org>; Tue, 14 Mar 2023 10:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678816443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkZ54jNTo6DPQkhoPBtvqCHeTti5iJyjn+V1YsN88Ds=;
        b=oYS4ucm0F6RX65Y9lv9RrtY9n8tdqfCYMYf70APsZR6fA8Eb1rrbsfTbQS7bXRsbBX
         yJtNCdHBXchSqo60JsD7FI1xWTazkm9IanTqrbp4EK5QIw1MXDNg8/rMAOALlM8ar0JW
         /bX8jQq0RRQc+kyO3Igfi/4abPtM7yfTmrz4yM90UUxbKh9hcvEDUjL4xXpnyjKjOpmV
         VjgGZbQWxPFcjIPHl76o3ctUULrnKykTMaTOtgh6YCl4t+00oLgNrBHgaZ3AxONvwzR0
         FjcbywR67JUdSvb9h1DnvHxVfVq1f1G1+3CYiwHI/qu7HkofFDo5qdvqzd9vRa4anZr0
         Chpw==
X-Gm-Message-State: AO0yUKWsmu8DRR6+Z+epmQElIpTl2xTBxHK8r0accO9CPBOi4xwXkRMV
        V89AaHvTuiZMuDnTbhyHGm6MXr+qQyqjhgijW5Sg90iu
X-Google-Smtp-Source: AK7set/3s+PST4zOt7tsDz779v0rrbnfpxrj/gPayTvMDSlMsDfGxTLrAcQby012MGmXd21WfigbVWDMobqKneskE+8=
X-Received: by 2002:a17:906:560b:b0:8b1:3540:7632 with SMTP id
 f11-20020a170906560b00b008b135407632mr1911727ejq.2.1678816443397; Tue, 14 Mar
 2023 10:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230313222652.402272-1-todd.e.brandt@linux.intel.com>
In-Reply-To: <20230313222652.402272-1-todd.e.brandt@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Mar 2023 18:53:51 +0100
Message-ID: <CAJZ5v0hWr+atCOfx5NBhvjpUUZOAZ+pfTYBuwE3cs7sbM-BgRA@mail.gmail.com>
Subject: Re: [PATCH v2] pm-graph v5.10 regression fix
To:     Todd Brandt <todd.e.brandt@linux.intel.com>
Cc:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        rjw@rjwysocki.net, todd.e.brandt@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 13, 2023 at 11:26 PM Todd Brandt
<todd.e.brandt@linux.intel.com> wrote:
>
> A regression has occurred in the hid-sensor code where a device
> name string has not been initialized to 0, and ends up without
> a NULL char and its printed with %s. This includes random binary
> data in the device name, which makes its way into the ftrace output
> and ends up crashing sleepgraph because it expects the ftrace output
> to be ASCII only.
>
> For example: "HID-SENSOR-INT-020b?.39.auto" ends up in ftrace instead
> of "HID-SENSOR-INT-020b.39.auto". It causes this crash in sleepgraph:
>
>   File "/usr/bin/sleepgraph", line 5579, in executeSuspend
>     for line in fp:
>   File "/usr/lib/python3.10/codecs.py", line 322, in decode
>     (result, consumed) = self._buffer_decode(data, self.errors, final)
> UnicodeDecodeError: 'utf-8' codec can't decode byte 0xff in position
> 1568: invalid start byte
>
> The issue is in 6.3-rc1 and is decribed in full here:
> https://bugzilla.kernel.org/show_bug.cgi?id=217169
>
> I've submitted a separate fix to have this issue repaired, but
> it has also exposed a larger bug in sleepgraph, since nothing should make
> sleepgraph crash. Sleepgraph needs to be able to handle biary
> data showing up in ftrace gracefully.
>
> I've changed the ftrace processing code to treat it as potentially
> binary and to filter out binary data and leave just the ASCII.

Thanks a lot for the detailed description of the problem, it helps quite a bit.

I've modified the subject and changelog somewhat and applied this as
6.3-rc material, thanks!

> Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> ---
>  tools/power/pm-graph/sleepgraph.py | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
> index 82c09cd25cc2..bf4ac24a1c7a 100755
> --- a/tools/power/pm-graph/sleepgraph.py
> +++ b/tools/power/pm-graph/sleepgraph.py
> @@ -5556,9 +5556,8 @@ def executeSuspend(quiet=False):
>                 if not quiet:
>                         pprint('CAPTURING TRACE')
>                 op = sv.writeDatafileHeader(sv.ftracefile, testdata)
> -               fp = open(tp+'trace', 'r')
> -               for line in fp:
> -                       op.write(line)
> +               fp = open(tp+'trace', 'rb')
> +               op.write(ascii(fp.read()))
>                 op.close()
>                 sv.fsetVal('', 'trace')
>                 sv.platforminfo(cmdafter)
> --
