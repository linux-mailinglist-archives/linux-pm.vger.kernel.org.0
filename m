Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CC672185F
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jun 2023 18:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjFDQAA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sun, 4 Jun 2023 12:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjFDP77 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jun 2023 11:59:59 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56663BB
        for <linux-pm@vger.kernel.org>; Sun,  4 Jun 2023 08:59:58 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-977d3292be0so16956966b.1
        for <linux-pm@vger.kernel.org>; Sun, 04 Jun 2023 08:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685894397; x=1688486397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRoNxg0TT+kZgn775fw3xbqdv0W7dCW4E8mcjC02JbI=;
        b=fcHm9e7v6vmT5PkujYDfBNVS1p1WAz4LCS+c5Qzh8RRYtpZTn+kY0DHymuAmi6EbgE
         lNlcL5OwI9KzQxxd727j/oi2yY5mguhGxTEcf6J7Etf5N/mSGHbMwqKyUDp8UZzg3blx
         KWgGMc1B5NnzJYD5LfDhhcnWHjKq17bY8qN8RjoKszw0rTW3c8zjjC6IJ1zGEl9InoLH
         9EPVZnmrmHzlScHhUU1XRm3BGPLJ7Z9Oa7jq1J2oBlPfbQtAQ5jFw+au5ZZXE/qjlAJJ
         pThSrYOG83y/w8XB0OneSePNVo9Ws//MR0iVvm4EoQyczvX1ViB4Ddx8aXf5DQdkE+36
         Wo0g==
X-Gm-Message-State: AC+VfDzRlv/BS5FwyVHe6a4FcjrQnoWChqhZoxKBcDTFFUxb0yQNlG1G
        ORshLbUerJ1QcU4ESkhWmMh2WcaSlBt0RxDq8Lg=
X-Google-Smtp-Source: ACHHUZ7cdL+fRFe4vmbSqoRDIinnhQnsmP9hkQ0VKB34ZsneW8LiKfcRF8SuCvt8YsuwHhzPVwHJydcKNq27sZq3/bk=
X-Received: by 2002:a17:906:77c6:b0:977:cc87:62b5 with SMTP id
 m6-20020a17090677c600b00977cc8762b5mr2258253ejn.4.1685894396478; Sun, 04 Jun
 2023 08:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230601182801.2622044-1-arjan@linux.intel.com> <20230601182801.2622044-7-arjan@linux.intel.com>
In-Reply-To: <20230601182801.2622044-7-arjan@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 4 Jun 2023 17:59:45 +0200
Message-ID: <CAJZ5v0h7VjEXaXzH1aiOP8PLdGLeYde6GkCbwJLLWLgx-Pnk4Q@mail.gmail.com>
Subject: Re: [PATCH 6/7] intel_idle: Add support for using intel_idle in a VM
 guest using just hlt
To:     arjan@linux.intel.com
Cc:     linux-pm@vger.kernel.org, artem.bityutskiy@linux.intel.com,
        rafael@kernel.org, Arjan van de Ven <arjan.van.de.ven@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 1, 2023 at 8:28 PM <arjan@linux.intel.com> wrote:
>
> From: Arjan van de Ven <arjan.van.de.ven@intel.com>
>
> In a typical VM guest, the mwait instruction is not available, leaving only the
> 'hlt' instruction (which causes a VMEXIT to the host).

What if it is available?  It can be AFAICS.

> So currently, intel_idle will detect the lack of mwait, and fail
> to initialize (after which another idle method would step in which will
> just use hlt always).
>
> By providing capability to do this with the intel_idle driver, we can
> do better than this fallback. While this current change only gets us parity
> to the existing behavior, later patches in this series will add new capabilities.
>
> In order to do this, a simplified version of the initialization function
> for VM guests is created, and this will be called if the CPU is recognized,
> but mwait is not supported, and we're in a VM guest.

It will cause intel_idle to become the idle driver in some cases in
which ACPI idle is used nowadays if I'm not mistaken.  Wouldn't that
be regarded as a problem?

> One thing to note is that the latency (and break even) of this C1 state
> is higher than the typical bare metal C1 state. Because hlt causes a vmexit,
> and the cost of vmexit + hypervisor overhead + vmenter is typically in the
> order of upto 5 microseconds... even if the hypervisor does not actually
> goes into a hardware power saving state.
>
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> ---
>  drivers/idle/intel_idle.c | 54 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 55c3e6ece3dd..c4929d8a35a4 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1280,6 +1280,18 @@ static struct cpuidle_state snr_cstates[] __initdata = {
>                 .enter = NULL }
>  };
>
> +static struct cpuidle_state vmguest_cstates[] __initdata = {
> +       {
> +               .name = "C1",
> +               .desc = "HLT",
> +               .flags = MWAIT2flg(0x00) | CPUIDLE_FLAG_IRQ_ENABLE,
> +               .exit_latency = 5,
> +               .target_residency = 10,
> +               .enter = &intel_idle_hlt_irq, },
> +       {
> +               .enter = NULL }
> +};
> +
>  static const struct idle_cpu idle_cpu_nehalem __initconst = {
>         .state_table = nehalem_cstates,
>         .auto_demotion_disable_flags = NHM_C1_AUTO_DEMOTE | NHM_C3_AUTO_DEMOTE,
> @@ -2105,6 +2117,46 @@ static void __init intel_idle_cpuidle_devices_uninit(void)
>                 cpuidle_unregister_device(per_cpu_ptr(intel_idle_cpuidle_devices, i));
>  }
>
> +static int __init intel_idle_vminit(const struct x86_cpu_id *id)
> +{
> +       int retval;
> +
> +       cpuidle_state_table = vmguest_cstates;
> +       skip_mwait_check = true; /* hypervisor hides mwait from us normally */
> +
> +       icpu = (const struct idle_cpu *)id->driver_data;
> +
> +       pr_debug("v" INTEL_IDLE_VERSION " model 0x%X\n",
> +                boot_cpu_data.x86_model);
> +
> +       intel_idle_cpuidle_devices = alloc_percpu(struct cpuidle_device);
> +       if (!intel_idle_cpuidle_devices)
> +               return -ENOMEM;
> +
> +       intel_idle_cpuidle_driver_init(&intel_idle_driver);
> +
> +       retval = cpuidle_register_driver(&intel_idle_driver);
> +       if (retval) {
> +               struct cpuidle_driver *drv = cpuidle_get_driver();
> +               printk(KERN_DEBUG pr_fmt("intel_idle yielding to %s\n"),
> +                      drv ? drv->name : "none");
> +               goto init_driver_fail;
> +       }
> +
> +       retval = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "idle/intel:online",
> +                                  intel_idle_cpu_online, NULL);
> +       if (retval < 0)
> +               goto hp_setup_fail;
> +
> +       return 0;
> +hp_setup_fail:
> +       intel_idle_cpuidle_devices_uninit();
> +       cpuidle_unregister_driver(&intel_idle_driver);
> +init_driver_fail:
> +       free_percpu(intel_idle_cpuidle_devices);
> +       return retval;
> +}
> +
>  static int __init intel_idle_init(void)
>  {
>         const struct x86_cpu_id *id;
> @@ -2123,6 +2175,8 @@ static int __init intel_idle_init(void)
>         id = x86_match_cpu(intel_idle_ids);
>         if (id) {
>                 if (!boot_cpu_has(X86_FEATURE_MWAIT)) {
> +                       if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
> +                               return intel_idle_vminit(id);
>                         pr_debug("Please enable MWAIT in BIOS SETUP\n");
>                         return -ENODEV;
>                 }
> --
> 2.40.1
>
