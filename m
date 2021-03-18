Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B68340D39
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 19:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhCRSiY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 14:38:24 -0400
Received: from mail-oo1-f45.google.com ([209.85.161.45]:41777 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbhCRShx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 14:37:53 -0400
Received: by mail-oo1-f45.google.com with SMTP id q127-20020a4a33850000b02901b646aa81b1so1670666ooq.8
        for <linux-pm@vger.kernel.org>; Thu, 18 Mar 2021 11:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y7z8OOmqs8rTW1usLZxdPviwc50qZpUCCtGkLjKXghY=;
        b=dzqrMG3xK0pz79yiWeT6iE/Mu7vl3G69koqYwkBu/EHEDIx32mTq2bFb628BNsInxY
         SJX0rl05EWNFktlhdMc0kxAokhrztm12eJahqs4AOFIO7tEroBpyNszipD/ETr58VCwe
         1XcfNDrW886lpwtlJDGWfQKnHQWzeTmIvD6NfLN5xQB8w2itris7EjJ9IhQJkF117Wlp
         lKqTnHWkFoCPqDT64fmIatuKq31OSB9dlqfCdt/xSXyJooDt2h/+1Z2hGM+v3GuWxdCI
         lk6Z5MkIiVrXnGghdM+jPNfH01pTHyWOhW8K5de3seqG2giXQxQgBE5qDzsTbWs0Uc++
         TKjA==
X-Gm-Message-State: AOAM532vpdwA5otrnj92Iz9egKxXIPwb9K5Al4tlwTjmqqsYStPme4Fd
        gXIpgUJVIozT9ovG0nFkomIrrQksNIfBQXAeOazVQWvL
X-Google-Smtp-Source: ABdhPJyz9oAHJtRHYfiwf+L0Br1I6hUUnLtUCrG4fp5sWhR/1YxJYjHC7tnyh1aT44VzrRUdzin3I9Qh2TrWsZSKoO0=
X-Received: by 2002:a4a:bb14:: with SMTP id f20mr8708160oop.1.1616092672768;
 Thu, 18 Mar 2021 11:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210308143146.3443166-1-dedekind1@gmail.com>
In-Reply-To: <20210308143146.3443166-1-dedekind1@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Mar 2021 19:37:41 +0100
Message-ID: <CAJZ5v0iD0peQa+ze38cW05_U_WiKDTCA_6LgQe8Q6V1FRODVkg@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: update ICX C6 data
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 8, 2021 at 3:31 PM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> This patch changes IceLake Xeon C6 latency from 128 us to 170 us. The latency
> was measured with the "wult" tool and corresponds to the 99.99th percentile
> when measuring with the "nic" method. Note, the 128 us figure correspond to the
> median latency, but in intel_idle we use the "worst case" latency figure
> instead.
>
> C6 target residency was increased from 384 us to 600 us, which may result in
> less C6 residency in some workloads. This value was tested and compared to
> values 384, and 1000. Value 600 is a reasonable tradeoff between power and
> performance.
>
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Acked-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/idle/intel_idle.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Changelog:
> v2->v3: Change target_residency from 1000us to 600us, based on Rui's feedback.
> v1->v2: Re-measured ICX with newer BIOS 21D02, which has C1 demotion bug fixed.
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 3273360f30f7..6cac0b748efa 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -744,8 +744,8 @@ static struct cpuidle_state icx_cstates[] __initdata = {
>                 .name = "C6",
>                 .desc = "MWAIT 0x20",
>                 .flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
> -               .exit_latency = 128,
> -               .target_residency = 384,
> +               .exit_latency = 170,
> +               .target_residency = 600,
>                 .enter = &intel_idle,
>                 .enter_s2idle = intel_idle_s2idle, },
>         {
> --

Applied as 5.13 material, thanks!
