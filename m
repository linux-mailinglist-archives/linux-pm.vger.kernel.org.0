Return-Path: <linux-pm+bounces-36957-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECDFC1359E
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 08:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373AB5E26A3
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 07:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412D323C39A;
	Tue, 28 Oct 2025 07:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpw7dwnB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDE022D795
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761637148; cv=none; b=bGE3AsCENHl6h94jsRiFgjZbLuzEOigYotS1pefHa0L7mHDH/GQf2imE0Fjg4H9s5xD3pKrRCh41x7PQMkD8alzct66Tdk298oKEcFe7gfNrBVYfHM6ds76hsewFN6G3CXZTp7WFXdDr+5RMX9ryMhDhtGXPPJCOcCh1fGcv0z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761637148; c=relaxed/simple;
	bh=sH3e7s8xPB6+HNIGAMv6PrTNEE0dGDJnlF85p02RvL0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=c2rdlxFR9glff1J455SDfGn4iWHXNcbBx2EQIdcYLE/6EEvPAI33WCABPx/MuFDM7zWUtVPsHHM8j9E6J05srvqXDC5rgOJLtIvRCjOSSCMJCOlkQFRnR/2sgnoc3Svni9gTQoGHKaXGtVnKz2hCKwpiSgoNe+WzvDJeDnoseQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpw7dwnB; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b6ce696c18bso5173197a12.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 00:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761637145; x=1762241945; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fZQcAE3NiFPEWRiaaSdgMTBw653ZGnPFrSKRDHStXzg=;
        b=hpw7dwnB55uSuP5Je5uhHmIz73ieUoyx1pj2j8piFq/CcOuCuFHBFwt1BWnBmMZ18U
         +UWiVOifZT+SJpKooYd9Hke/7rGEwoY4pFfuig7NGasUIKr9qrdigb1J1S3jE9BCbDaB
         ZCINEKQbm2bSQqPelFfid1Slt4Z5pOMth3iDHgcTIzrUwdrsvJxVKCCJbWfC2cHhVj9x
         5f9LWv5X6KRX34X4hi7gm4aBLwKBDzKvmTEg/msC2mdOyu/PmJUaRcQdsvhA57EpyKse
         uhRRtO0dHS04omzW3F2FH03qFJTtubHC4fyo/ESS6VUIMO26E5cCb7Y3TOFW6RQ8ECQl
         nr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761637145; x=1762241945;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fZQcAE3NiFPEWRiaaSdgMTBw653ZGnPFrSKRDHStXzg=;
        b=DXqnDgCA7osm8FRsHEXJEdWq0dXDOXx2EX1iiGi4L02D5QYB6E+/PLR/q4mo0t9dET
         s2sGLALCZe2YdiGCZCFE9OeM2JaR+HZIjk4UdIJXSdM/VgPu/WKnPt6dbMwtfVole1sC
         WMlF0FPWpqsiNrD7y5NuSmtOD2yNbUKW3k44+Y6XPic9UH3l+1AjFAN6FK0oMRSCmSfG
         KzpCjsVQwiTzVF4TBdwqvJQe2KmEaJ+M7E/cxkRk7XVZc8TqbkrjuNqTJ7jIxuJen6B2
         iDEA+Cf5Va4InbXd+gL+WzIDtY+GoAs5iO9qrvV5YGIEn+UwWtXYFAxmzC0BuWp5Gw+T
         73cQ==
X-Gm-Message-State: AOJu0Yy93ShwxZgyL4G//x3PmGsV4l9QO/IWIkaawnhNd2M/FTnb9Uuo
	ZJMrmqG9R3aYY1ibmzGP7qeZPQPdM7fux6NOK0/nU6PKWhayUQNFTbaK9m2JmPZ8+cLAO3Gestr
	J6CrHtlliL1t/n9ok12ZiYRPCbSM9a6q/mqMduyemKg==
X-Gm-Gg: ASbGncuqj98RMNgpaFiASb9xURDfx5G2HDlhFp7go6XpICLP8vrWIbYLbiIeIqQ958L
	rx9/mt1B2eKkP6ZRClwqVnqghFAQNo5+veipiQR2aNNXtxmVxrCU6D9oHBmSfjo4Z38XlwbQKV9
	XStf9TGUcYJUEXvEylC6wkDId00SclObDOJNd8xX0JNMcHuWtoLbYqS/V8388AHgNv5E1jeQ8Xe
	xfLMNNZlrm7PcQU+vu6P9N93lxgLWnsHCoZ/NRt2U2kKQ0H1SoD4WasnscERWb1/XgmWnRaC8tL
	Io800W7oZ2m1Hw==
X-Google-Smtp-Source: AGHT+IGFh2TYLasVGXUF21rpEaEF/tSw6kHufc0/I2DgN9Fg5FFpCLuzmunsuUK3bHPgMcURl/Aj5TjMj7GW+UrQwnM=
X-Received: by 2002:a17:902:ce91:b0:27e:e1f3:f853 with SMTP id
 d9443c01a7336-294cb35ec0emr25822415ad.8.1761637145420; Tue, 28 Oct 2025
 00:39:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christopher Harris <chris.harris79@gmail.com>
Date: Tue, 28 Oct 2025 00:38:54 -0700
X-Gm-Features: AWmQ_bnrt0pbyscnBc_FU7k8Dqzb61ZnfyKrV__muDPkT_bA0X_pvnkmcGfo5-g
Message-ID: <CAM+eXpdDT7KjLV0AxEwOLkSJ2QtrsvGvjA2cCHvt1d0k2_C4Cw@mail.gmail.com>
Subject: [REGRESSION] AMD P-State fails with "_CPC object is not present" on
 AMD Zen 4 (EPYC 4484PX) between 6.10 and 6.11
To: linux-pm@vger.kernel.org
Cc: regressions@lists.linux.dev, mario.limonciello@amd.com, perry.yuan@amd.com, 
	rafael@kernel.org, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

#regzbot introduced: v6.10..v6.11

[Regression precisely identified: Last working 6.10.0, first broken 6.11.0]

## Summary

The AMD P-State driver fails to initialize on AMD EPYC 4484PX
processors starting
with kernel 6.11.0, returning "_CPC object is not present in SBIOS or
ACPI disabled"
error. The same hardware works correctly with kernel 6.10.0 and earlier.

The regression was introduced between 6.10.0 and 6.11.0.

## Hardware

- CPU: AMD EPYC 4484PX 12-Core Processor (Zen 4 architecture)
- Motherboard: SuperMicro (confirmed CPPC enabled in BIOS by vendor)
- Tested on multiple identical systems

Note: This issue likely affects other AMD Zen 4 processors and
possibly other AMD
generations, though testing has been performed specifically on EPYC
4484PX systems.

## Regression Test Results

**Working** (amd-pstate loads successfully):
- 6.8.0-84-generic (Ubuntu 24.04)
- 6.8.0-86-generic (Ubuntu 24.04)
- 6.9.0-060900-generic (Ubuntu mainline)
- 6.10.0-061000-generic (Ubuntu mainline)
- 6.10.14-061014-generic (Ubuntu mainline) **<-- LAST WORKING (latest 6.10.x)**

**Broken** (falls back to acpi-cpufreq with _CPC error):
- 6.11.0-061100-generic (Ubuntu mainline) **<-- FIRST BROKEN**
- 6.12.0-061200-generic (Ubuntu mainline)
- 6.13.0-061300-generic (Ubuntu mainline)
- 6.14.0-061400-generic (Ubuntu mainline)
- 6.16.7-061607-generic (Ubuntu mainline)
- 6.17.1-061701-generic (Ubuntu mainline)
- 6.17.5-061705-generic (Ubuntu mainline)
- 6.18.0-061800rc3-generic (Ubuntu mainline RC)
- 6.17.1-1-cachyos-server-lto (Arch Linux)

## Error Message

```
[    4.508125] amd_pstate: the _CPC object is not present in SBIOS or
ACPI disabled
```

## Steps to Reproduce

1. Boot with kernel parameter: amd_pstate=passive
2. Check driver: cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
   Expected: amd-pstate
   Actual: acpi-cpufreq
3. Check dmesg: dmesg | grep "_CPC"
   Shows: "the _CPC object is not present in SBIOS or ACPI disabled"

## Kernel Configuration (identical in working and broken kernels)

```
CONFIG_ACPI_CPPC_LIB=y
CONFIG_X86_AMD_PSTATE=y
CONFIG_X86_AMD_PSTATE_DEFAULT_MODE=3
CONFIG_X86_AMD_PSTATE_UT=m
```

## Testing Environment

- Tested with vanilla kernels from Ubuntu mainline PPA
- No additional modules or patches
- Kernel not tainted
- Reproduced on both Ubuntu 24.04 and Arch Linux distributions

## Impact

This regression prevents affected AMD systems from using the optimized
AMD P-State
driver, forcing fallback to generic acpi-cpufreq with approximately 5-10%
performance loss. While confirmed on AMD EPYC 4484PX (Zen 4), this
likely affects
a broader range of AMD processors that support CPPC/ACPI P-States.

## Next Steps

I'm prepared to:
1. Run amd-debug-tools to capture detailed reports if needed
2. Test any proposed patches
3. Perform git bisect between 6.10 and 6.11 if required
4. Provide any additional debugging information

## Bisection Results

Through systematic testing of Ubuntu mainline kernels, I've identified the exact
regression window:

- **Last working version**: 6.10.14-061014-generic (latest 6.10.x series)
- **First broken version**: 6.11.0-061100-generic

The regression was introduced during the 6.11 merge window. All 6.10.x versions
work correctly (tested through 6.10.14), while all 6.11+ versions
fail. The issue
persists through all subsequent versions tested up to 6.18.0-rc3.

The regression appears to be in ACPI _CPC object detection/parsing, as the same
BIOS/hardware combination works with the entire 6.10.x series but
fails with 6.11+.

## Additional Information

The same ACPI tables and BIOS work correctly with 6.8 kernels, confirming
this is not a firmware issue but a kernel regression in CPPC/ACPI handling.

ACPI/CPPC related messages from working system (6.8.0):
- No error messages, driver loads successfully

ACPI/CPPC messages from broken system (6.17.5):
```
$ zgrep "ACPI.*CPPC" /proc/config.gz
CONFIG_ACPI_CPPC_LIB=y
$ dmesg | grep amd_pstate
[    0.714133] amd_pstate: the _CPC object is not present in SBIOS or
ACPI disabled
```

I've tested on multiple identical systems with the same results. I'm available
for testing patches or providing additional debugging information as needed.

Thank you for your attention to this regression.

Best regards,

Chris Harris
chris.harris79@gmail.com

