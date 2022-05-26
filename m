Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE6353566C
	for <lists+linux-pm@lfdr.de>; Fri, 27 May 2022 01:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348929AbiEZXfS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 19:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbiEZXfR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 19:35:17 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D7FE64F2
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 16:35:15 -0700 (PDT)
Date:   Thu, 26 May 2022 23:35:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dannyvanheumen.nl;
        s=protonmail2; t=1653608112; x=1653867312;
        bh=grkw/N3Ufe47AJhCwr7I5s4vhnscpcQrsxjtpymxzjc=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=el8DoHYQxrr4DwNKoWxavO63D0Ev5wAKSOGIHDgrUABMhxE03do53JTpEXnbY798i
         HRU5Vd5Dw3SwmKImQUhPKvZ3QZXVwM5/b/u8XR9aRmrZAVXRKpWdb+uPr0xAsV8ske
         p8ieZvrpItnM4ugihpvd3WHWuXs0YU7IotGQTFJKworuINT5p6UnjsUU/9J+jNLJDc
         3G4R7jcgKqL/FLCo6/SHuYq0VIsq8WmlcxsZV2vaMD1TsJA6hXlAMaaTnwhMFQ/CRv
         Nwo3h/ze6tKkoS1SWaoYZ9AnGfeiLvB4tkXR1b90a5Ve5Hv7iI/O+pTmHbjhzr/BrA
         hlw1OeP8hQYuA==
To:     Viresh Kumar <viresh.kumar@linaro.org>
From:   Danny van Heumen <danny@dannyvanheumen.nl>
Cc:     =?utf-8?Q?=E2=80=9CRafael_J=2E_Wysocki=E2=80=9D?= 
        <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Reply-To: Danny van Heumen <danny@dannyvanheumen.nl>
Subject: Re: 'schedutil' (possibly) aberrant behavior surrounding suspend/resume process (timing/delay/run-away CPU issues)
Message-ID: <B3ov-60gJemUh6jis14BfIzBAgiN8DgvrVFZ2RkN891DiItqKwZ6LbXvB72OEwXB489pUOrWnZ-mD17S_nLgsvdguRDRIpcYdLOAjWmpMyk=@dannyvanheumen.nl>
In-Reply-To: <B6Vf9ZGyW3CDcuxpGzU6WbTq7cEi6z-3zrd0JIlop56-d5R3JiD1eQPrLcoM41xDz8_WYWTvQhodW7NLSDURsXl4cRpzsk-UhF17J5Mu5j4=@dannyvanheumen.nl>
References: <R6AlCxZca3GET8vtwpOAkzQ4Y9SX-NOVQ05FlJAKDUvNTYCAhsWy1e0q5soCkapaviI8SS-9eC51nwJj6yn6n1rFAlwndEqYqlr_hqz4C_U=@dannyvanheumen.nl> <20220525052804.rvnp2jinpmz7vukx@vireshk-i7> <34KkbDDzdEpklXuY3YwJi95cgyhc44xzV-xQVDRRuKctbmHUdH8Ddm2LMcSUVNVmwtGUaB73-yOqIijCnMFRfh3aYxlKOKcrrRyCHb2uOPw=@dannyvanheumen.nl> <20220526032600.dlbrrppqovizwpvs@vireshk-i7> <B6Vf9ZGyW3CDcuxpGzU6WbTq7cEi6z-3zrd0JIlop56-d5R3JiD1eQPrLcoM41xDz8_WYWTvQhodW7NLSDURsXl4cRpzsk-UhF17J5Mu5j4=@dannyvanheumen.nl>
Feedback-ID: 15073070:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

------- Original Message -------
On Thursday, May 26th, 2022 at 17:01, Danny van Heumen <danny@dannyvanheume=
n.nl> wrote:

> [..]
>
> Right. Thas already was my intention. I have already done more tests. I
> notice now that this seems to be a pattern such that if it occurs once,
> it keeps on occurring.
>
> I see patterns such as below, where first thermal is before suspend,
> second thermal is immediately after waking up. Note that apparently
> some intel driver logic prevents full suspend with temp > 50 degrees.
>
> I have very similar behavior to that case, but with temperature confirmed
> below 50 degrees.
>
> Below is a quick test of about 3 minutes time.
>
> ```console
>
> > sensors pch_skylake-virtual-0; echo 'mem' | sudo tee /sys/power/state; =
\
>
> sensors pch_skylake-virtual-0
>
> pch_skylake-virtual-0
> Adapter: Virtual device
> temp1: +47.5=C2=B0C
>
> mem
>
> pch_skylake-virtual-0
> Adapter: Virtual device
> temp1: +57.5=C2=B0C
> dmesg
> intel_pch_thermal 0000:00:14.2: CPU-PCH is cool [47C], continue to suspen=
d
> pcieport 0000:00:1c.5: Intel SPT PCH root port ACS workaround enabled
> ACPI: EC: interrupt blocked
> nvme nvme0: I/O 1015 QID 2 timeout, aborting
> nvme nvme0: I/O 22 QID 0 timeout, completion polled
> nvme nvme0: Abort status: 0x0
> ACPI: EC: interrupt unblocked
> pcieport 0000:00:1c.5: Intel SPT PCH root port ACS workaround enabled
> pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
> pcieport 0000:00:1c.0: Intel SPT PCH root port ACS workaround enabled
> pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
> usb 1-3: reset full-speed USB device number 2 using xhci_hcd
> OOM killer enabled.
> Restarting tasks ...
> mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound \
> 0000:00:02.0 (ops i915_hdcp_component_ops [i915])
> done.
> systemd[1]: systemd-journald.service: Main process exited, code=3Dkilled,=
 \
> status=3D6/ABRT
> systemd[1]: systemd-journald.service: Failed with result 'watchdog'.
> systemd[1]: systemd-journald.service: Consumed 1.844s CPU time.
> systemd[1]: systemd-journald.service: Scheduled restart job, restart coun=
ter \
> is at 1.
> systemd[1]: Stopping Flush Journal to Persistent Storage...
> systemd[1]: Stopped target Bluetooth.
> systemd[1]: Started Load/Save RF Kill Switch Status.
> PM: suspend exit
> ```
>
> This is just to illustrate some tries. I will continue to test, to
> figure out if I can either trigger the circumstances without
> 'schedutil' (which clears my suspicion) or otherwise try to make it
> more deterministic, reproducible.
>
> The nvme errors in dmesg are new to me. I have not seen those before.
> So I will also keep an eye out for those.

Today I stumbled into the issue with 'ondemand' governor enabled from
boot. So schedutil does not need to be or have been active for
this issue to emerge. I still have many questions left, but they are
not schedutil related.

The aarch64-based Pinebook Pro issues are not explained yet, but I will
investigate further and possibly follow up later.

> [..]
>
> > --
> > viresh
