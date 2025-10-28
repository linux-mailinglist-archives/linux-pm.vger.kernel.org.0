Return-Path: <linux-pm+bounces-36996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FF0C1762C
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 00:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B95024E171E
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 23:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A1E34DCF4;
	Tue, 28 Oct 2025 23:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dp3bGwPb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6A52C21EB
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761694838; cv=none; b=WM4zoM08sxGD1JmwexNnBFzVkOH5Cop83+C3ycC561ck6SLukko4DooaqUbg8hon8OoLkwBa+Y+35gl2OOeYlhj440ni/5WB6QsEuv5DGgj3J6Y1BniTbgBY8tBPxzUPf52HmKLxBHd5JpBcWHUUTgbcrsCFnVZ/KJKb31gq2Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761694838; c=relaxed/simple;
	bh=L4p5T9/5YLgEDDGRSp3rGrSrREoF3pb8AWOLlEDjHL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfmrUd/SRIKXjcsp8QD2b7iC9BtakU45ZULTgK8RTVTwfEMklnOQcfFTj0ryp5GexdoBhfbCh824wrf5fZNH+TRX5hlkXwJgxN0nm0ytFYXKiKmcq3UkztnNT+zbEFKCyRmUzPBkkEnxrGyT06L92jLqolafaR4ZYUFwBZZXzmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dp3bGwPb; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a27053843bso9081588b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 16:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761694836; x=1762299636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=496R/rU8XRqgGL8BRr6loe9ZwMWF2avVD3KhJQPvFII=;
        b=dp3bGwPbNARrCKJHOiwYK9AnXyS11qDNydh32Zkq9nRQQV7WpAQXZ1b8u6dHZNzw15
         XJncyTdK/5c8r1qUgGFSUoNbNjh948TO6Or+4BRI4Kv3cM3dVrOff9eRZraN/R76wpjo
         qWbLjcmVxF9useK/O/yjAqeAP0dT8AyP7nSY8saKrZZWTdSquNkEeCHc48mLMRkpBn7d
         N7vD33qjnRtDPEUeIhfGIbDtjeSXyZPI7LozOcM5qibAPXX2VU+id3qPuQouSUq7umwp
         Gp9Yt/HEQOMK4E7nfGyi6fIMaJVknhkkuMTODKPDslEAoq4CwnanWOL6AacF23I+DQBA
         wByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761694836; x=1762299636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=496R/rU8XRqgGL8BRr6loe9ZwMWF2avVD3KhJQPvFII=;
        b=MU26tCwFG0TmNaMnreNhBNSa82xGZY9wlTmujA5e2GcedG8DDrbhfK+ZkixHfijTRp
         LtWJE1V6vmjh+VYNNmleFNvW2V1qhXOFz+LcDUFZhnW6z6kejJsyXogFAx/3b3U3643e
         3DhCoyhXxyhO9GViYIoroc8jI2moKtdppRlRiqcdg2PuU1XSMMja9RnxTm4Se5lwJE4e
         0KLL3momW36c2iNLbzDzXi0YRvzGAskQiZMgXTAq3j8z/6oAF3T1VQCgTDVFKzz64USg
         l/qXKN9AmgKipdj7J4Q33gCyvmet03o6pjw+ANZMSbCu/uJ71ZtHkAsCVYPd3tmnS30Y
         nDJA==
X-Gm-Message-State: AOJu0YzZwu9N0th/0espdh7omQMeRv9rdBcviR8kxng2lV0TJk1qEgHb
	52YNVHdb282fY6I9XvX3LTedqDhgcmzTlE5D2N9YGwxBVrIm8kwDD1gdLia2ntCo/sOUGAMX9nb
	pFxTjd7se9CRA4bz7Lj7OVE7TYlLj7Dk=
X-Gm-Gg: ASbGnctTAJCX1446LHeXUw3O06GcpN8pwMgmRuUjLCCNUy8e0zcL+F/vByaHTTXz3AZ
	D98eDonRrMMdZpluR08Fson3wlUzgdBBOBUojjUG59rnm1+rY1za9khK4Rt5x544aKYRslTaOPw
	E0Z2W5uzM9mtZ0LMy4YVJV10kuISBEQRYmUnw67A9Uk1R/P1codpfp/iwCVxEfjLpPcu9mOnUE1
	f8cXv1m/Z3JRIrtoOfnKHlT/KEVg89oVCRiOvshEM6q7UdJAdlhybir8F2oQdRBOJn6KsijOdMj
	NTYFKj3G+x/Sn4Kw
X-Google-Smtp-Source: AGHT+IFqDH+nrqzU9OHy2kv6k1yZAvG7H9VN41OEWfxp8VTI2djQ6VFJ3vCeg64naTPmBfvLuMk+qUQ+ZoD6BJIl9Fc=
X-Received: by 2002:a17:90b:1810:b0:332:84c1:31de with SMTP id
 98e67ed59e1d1-3403a28e647mr799587a91.25.1761694835714; Tue, 28 Oct 2025
 16:40:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM+eXpdDT7KjLV0AxEwOLkSJ2QtrsvGvjA2cCHvt1d0k2_C4Cw@mail.gmail.com>
 <9c264378-702b-4a5a-8012-984e15f91779@amd.com>
In-Reply-To: <9c264378-702b-4a5a-8012-984e15f91779@amd.com>
From: Christopher Harris <chris.harris79@gmail.com>
Date: Tue, 28 Oct 2025 16:40:22 -0700
X-Gm-Features: AWmQ_bljLRlTPZ_GCx_QtSaOUKDtx69XBWY0h08NcsjjgVU8fzPCsi2ujJX4Mdo
Message-ID: <CAM+eXpeTE=os=LfFQbGtMEo5ujx51S1gbrqvQ9wNXv4s_uz5qQ@mail.gmail.com>
Subject: Re: [REGRESSION] AMD P-State fails with "_CPC object is not present"
 on AMD Zen 4 (EPYC 4484PX) between 6.10 and 6.11
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org, "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your response. I've created the kernel bugzilla as requested:

   https://bugzilla.kernel.org/show_bug.cgi?id=3D220715

   I've attached:
   - acpidump
   - dmesg from 6.17.x (broken)
   - dmesg from 6.10.14 (working)

   Please let me know if you need any additional information.

Thanks again,

Chris Harris

On Tue, Oct 28, 2025 at 7:46=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 10/28/25 2:38 AM, Christopher Harris wrote:
> > #regzbot introduced: v6.10..v6.11
> >
> > [Regression precisely identified: Last working 6.10.0, first broken 6.1=
1.0]
> >
> > ## Summary
> >
> > The AMD P-State driver fails to initialize on AMD EPYC 4484PX
> > processors starting
> > with kernel 6.11.0, returning "_CPC object is not present in SBIOS or
> > ACPI disabled"
> > error. The same hardware works correctly with kernel 6.10.0 and earlier=
.
> >
> > The regression was introduced between 6.10.0 and 6.11.0.
> >
> > ## Hardware
> >
> > - CPU: AMD EPYC 4484PX 12-Core Processor (Zen 4 architecture)
> > - Motherboard: SuperMicro (confirmed CPPC enabled in BIOS by vendor)
> > - Tested on multiple identical systems
> >
> > Note: This issue likely affects other AMD Zen 4 processors and
> > possibly other AMD
> > generations, though testing has been performed specifically on EPYC
> > 4484PX systems.
> >
> > ## Regression Test Results
> >
> > **Working** (amd-pstate loads successfully):
> > - 6.8.0-84-generic (Ubuntu 24.04)
> > - 6.8.0-86-generic (Ubuntu 24.04)
> > - 6.9.0-060900-generic (Ubuntu mainline)
> > - 6.10.0-061000-generic (Ubuntu mainline)
> > - 6.10.14-061014-generic (Ubuntu mainline) **<-- LAST WORKING (latest 6=
.10.x)**
> >
> > **Broken** (falls back to acpi-cpufreq with _CPC error):
> > - 6.11.0-061100-generic (Ubuntu mainline) **<-- FIRST BROKEN**
> > - 6.12.0-061200-generic (Ubuntu mainline)
> > - 6.13.0-061300-generic (Ubuntu mainline)
> > - 6.14.0-061400-generic (Ubuntu mainline)
> > - 6.16.7-061607-generic (Ubuntu mainline)
> > - 6.17.1-061701-generic (Ubuntu mainline)
> > - 6.17.5-061705-generic (Ubuntu mainline)
> > - 6.18.0-061800rc3-generic (Ubuntu mainline RC)
> > - 6.17.1-1-cachyos-server-lto (Arch Linux)
> >
> > ## Error Message
> >
> > ```
> > [    4.508125] amd_pstate: the _CPC object is not present in SBIOS or
> > ACPI disabled
> > ```
> >
> > ## Steps to Reproduce
> >
> > 1. Boot with kernel parameter: amd_pstate=3Dpassive
> > 2. Check driver: cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_drive=
r
> >     Expected: amd-pstate
> >     Actual: acpi-cpufreq
> > 3. Check dmesg: dmesg | grep "_CPC"
> >     Shows: "the _CPC object is not present in SBIOS or ACPI disabled"
> >
> > ## Kernel Configuration (identical in working and broken kernels)
> >
> > ```
> > CONFIG_ACPI_CPPC_LIB=3Dy
> > CONFIG_X86_AMD_PSTATE=3Dy
> > CONFIG_X86_AMD_PSTATE_DEFAULT_MODE=3D3
> > CONFIG_X86_AMD_PSTATE_UT=3Dm
> > ```
> >
> > ## Testing Environment
> >
> > - Tested with vanilla kernels from Ubuntu mainline PPA
> > - No additional modules or patches
> > - Kernel not tainted
> > - Reproduced on both Ubuntu 24.04 and Arch Linux distributions
> >
> > ## Impact
> >
> > This regression prevents affected AMD systems from using the optimized
> > AMD P-State
> > driver, forcing fallback to generic acpi-cpufreq with approximately 5-1=
0%
> > performance loss. While confirmed on AMD EPYC 4484PX (Zen 4), this
> > likely affects
> > a broader range of AMD processors that support CPPC/ACPI P-States.
> >
> > ## Next Steps
> >
> > I'm prepared to:
> > 1. Run amd-debug-tools to capture detailed reports if needed
> > 2. Test any proposed patches
> > 3. Perform git bisect between 6.10 and 6.11 if required
> > 4. Provide any additional debugging information
> >
> > ## Bisection Results
> >
> > Through systematic testing of Ubuntu mainline kernels, I've identified =
the exact
> > regression window:
> >
> > - **Last working version**: 6.10.14-061014-generic (latest 6.10.x serie=
s)
> > - **First broken version**: 6.11.0-061100-generic
> >
> > The regression was introduced during the 6.11 merge window. All 6.10.x =
versions
> > work correctly (tested through 6.10.14), while all 6.11+ versions
> > fail. The issue
> > persists through all subsequent versions tested up to 6.18.0-rc3.
> >
> > The regression appears to be in ACPI _CPC object detection/parsing, as =
the same
> > BIOS/hardware combination works with the entire 6.10.x series but
> > fails with 6.11+.
> >
> > ## Additional Information
> >
> > The same ACPI tables and BIOS work correctly with 6.8 kernels, confirmi=
ng
> > this is not a firmware issue but a kernel regression in CPPC/ACPI handl=
ing.
> >
> > ACPI/CPPC related messages from working system (6.8.0):
> > - No error messages, driver loads successfully
> >
> > ACPI/CPPC messages from broken system (6.17.5):
> > ```
> > $ zgrep "ACPI.*CPPC" /proc/config.gz
> > CONFIG_ACPI_CPPC_LIB=3Dy
> > $ dmesg | grep amd_pstate
> > [    0.714133] amd_pstate: the _CPC object is not present in SBIOS or
> > ACPI disabled
> > ```
> >
> > I've tested on multiple identical systems with the same results. I'm av=
ailable
> > for testing patches or providing additional debugging information as ne=
eded.
> >
> > Thank you for your attention to this regression.
> >
> > Best regards,
> >
> > Chris Harris
> > chris.harris79@gmail.com
> >
>
> Please open a kernel bugzilla and CC me.  Please add an acpidump, a
> dmesg with a current kernel (6.17.y) and a dmesg with a last working kern=
el.

