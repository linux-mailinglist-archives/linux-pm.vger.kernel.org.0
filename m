Return-Path: <linux-pm+bounces-5627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F1E8915C9
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 10:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13514B21126
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 09:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E3A47F78;
	Fri, 29 Mar 2024 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aMUf17tT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0894595A
	for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704463; cv=none; b=R/P6ZyLumbtsV/AGxR7wA9uRzCvkZsCEq5wfowqZ9DajYWJHHCYiITs7A5p2mUL8Cv2d0h+NDjmYt7L6uBWzG0eF9x1xduuLA7A03YOw5FxiNArLgxqvi4HTjfQFKtajsnB77Yhyw4Z9K5zQst396q1Jo5//FIMGH0nWFJ3n4yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704463; c=relaxed/simple;
	bh=5ACZJa3Tq3dvPUxK1QZqVzKwAxpacncCtJOs3+hxanM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MzSg9gfnOMY45MwnOZcS8oJNAU9+SZX98EIBwunT39roIQBLdn+cTshZWehlYS/+Cz/HuvR/q9EGmNpWb9yebvKd7bQFOlBbNAe4EFFNWuC64pcJLEgqz2/HdtMLPY5fSWfeNsMWB45QI4ggJ4GP1BCz+pxoctl/uCOukMshqNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=aMUf17tT; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1def3340682so16399735ad.1
        for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 02:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711704460; x=1712309260; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wphdEuVRZdcfvU1uZa0UrVCyguVuaKQ82sqpzgvdX+0=;
        b=aMUf17tTpTNeG7DergaquCVpR+cZU7zIOULs2Ggzraeb1Y2NMbNJnPfhCLrpDCxUzN
         xIFjDc/kWvL+NSzp/6z0GpXaWpG+IO+LLay3VbHY4egNxMxfSDeGxAtUlZiSMxD8GYJc
         Vu/GFvoLEEPq7V4AlCIb+H3dsK2/oOVDlzU8eWQKJHP/+xe+ZoZYuzZwSb7v4cC+rClh
         Q+7sRAMLW71q2YZLSxsEFCFRDFL5eAWeK+CI7m+0ZFV2nCQXVnCDuqlJHhKHGa3bAqrT
         Kn9occ+rCWkAvOggGVEt7G8FkLlnZmck1QpDj9n07TnNUBo5BozKzjW3T68hVv44hshV
         Z6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711704460; x=1712309260;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wphdEuVRZdcfvU1uZa0UrVCyguVuaKQ82sqpzgvdX+0=;
        b=u1QrzAAcDc3RyiOt0euFAsoE6fhPnPYowcI6NqaZSRHT0aSMPbZ1cwoIpygfh1wFZo
         RXh7VwLPMewhup2XU311PfpladSCuw6+5oVL6FsqrrrDAJLY29mKslb2DTGPd7wzxdjr
         U0fFa5W5euf9yu+MWWo+iWiLQfgIWEr8bk3OBuqIkFH0cbQ6M5stoa9tAYHZAVy7f8DT
         BFZ0YPLy7zS0lVDTl8H2NPWyGpsWN337vUfsrT5J6+W+mmhMeE3VipXEchULEt0AbGg0
         Zmva91p1dBt5Py98cryigOcvAGmbhstQUmD6za925Nva8JV2FHwkGBtpezbwuZyeyUGA
         XPTg==
X-Forwarded-Encrypted: i=1; AJvYcCUonyoWlWYk4DYkzOm8lHnxHoP+5zJBo21LIVlLlOrhzOxdyIOcuCBr66HI0+c/Udi8/px+8k5vnADadjCCRMPRntXFJm2khkc=
X-Gm-Message-State: AOJu0Yy+re0/eHeTlUQPZ/Z4D1FgbpNyLOY0ocegg770FqCfMoauyiPU
	5gDyqNZZ3A39RrjofYd/nEO82VYlqZSNPnUgiiaLyeR9zyGlMJ9AWNmj0AoK4Mk=
X-Google-Smtp-Source: AGHT+IFf4f0IS4Sv1ofKMaYbSZwd8YlGOT1AaVNln1woRpkOY9F+Jd0NVeHAdCb352GScKE4g4Gsmw==
X-Received: by 2002:a17:90a:4216:b0:2a0:33c2:997e with SMTP id o22-20020a17090a421600b002a033c2997emr1713230pjg.41.1711704460537;
        Fri, 29 Mar 2024 02:27:40 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id cv17-20020a17090afd1100b002a02f8d350fsm2628830pjb.53.2024.03.29.02.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:27:40 -0700 (PDT)
From: Max Hsu <max.hsu@sifive.com>
Subject: [PATCH RFC 00/11] riscv: support Sdtrig extension
 hcontext/scontext CSRs
Date: Fri, 29 Mar 2024 17:26:16 +0800
Message-Id: <20240329-dev-maxh-lin-452-6-9-v1-0-1534f93b94a7@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADmJBmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyNL3ZTUMt3cxIoM3ZzMPF0TUyNdM11L3WQzIwPLVLOUJDPzNCWg1oK
 i1LTMCrCx0UpBbs5KsbW1ABEr0dRrAAAA
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 Max Hsu <max.hsu@sifive.com>, Nick Hu <nick.hu@sifive.com>, 
 Yong-Xuan Wang <yongxuan.wang@sifive.com>
X-Mailer: b4 0.13.0

riscv-debug-spec [1] Chapter 5: Sdtrig extension introduces
trigger CSRs which can cause a breakpoint exception,
entry into Debug Mode, or a trace action without having to
execute a special instruction.

The focus in the following patches is on the two CSRs from
the Sdtrig extension: hcontext and scontext.

These two CSRs are optional according to the spec, apart from
the Smstateen extension [2], which has bit 57 to control the
accessbility of the hcontext/scontext CSRs.
We also introduce dt-binding in the CPU DTS for the existence of
the CSRs in situations where the Smstaten extension is not available.

The hcontext/scontext CSRs can help to raise triggers with the
textra32/textra64 CSRs set up correctly. (Chapter 5.7.17/ 5.7.18 [1])

Therefore, as part of Linux awareness debugging. 
We propose the scontext CSR be filled by the Linux PID,
And the hcontext CSR be filled with a self-maintained Guest OS ID.

The reason for using the self-maintained Guest OS ID instead of VMID is
that VMID might change over time, and the user setting up the trigger
might enter the previous value, invoking the wrong VM for debugging.

The tests have been done on QEMU with Sdtrig CSRs
(mcontext/hcontext/scontext implemented) [3] boot on virt machine
and also run the Guest OS as virt machine with KVM enabled,
the two hcontext/scontext CSRs can be written correctly.

This patch series is based on v6.9-rc1.

Link: https://github.com/riscv/riscv-debug-spec/releases/download/ar20231208/riscv-debug-stable.pdf [1]
Link: https://github.com/riscvarchive/riscv-state-enable/releases/download/v1.0.0/Smstateen.pdf [2]
Link: https://github.com/sifive/qemu/tree/dev/maxh/sdtrig_ISA [3]

Signed-off-by: Max Hsu <max.hsu@sifive.com>
---
Max Hsu (7):
      dt-bindings: riscv: Add Sdtrig ISA extension
      dt-bindings: riscv: Add Sdtrig optional CSRs existence on DT
      riscv: Add ISA extension parsing for Sdtrig
      riscv: Add Sdtrig CSRs definition, Smstateen bit to access Sdtrig CSRs
      riscv: cpufeature: Add Sdtrig optional CSRs checks
      riscv: suspend: add Smstateen CSRs save/restore
      riscv: Add task switch support for scontext CSR

Yong-Xuan Wang (4):
      riscv: KVM: Add Sdtrig Extension Support for Guest/VM
      riscv: KVM: Add scontext to ONE_REG
      riscv: KVM: Add hcontext support
      KVM: riscv: selftests: Add Sdtrig Extension to get-reg-list test

 Documentation/devicetree/bindings/riscv/cpus.yaml  |  18 +++
 .../devicetree/bindings/riscv/extensions.yaml      |   7 +
 arch/riscv/include/asm/csr.h                       |   6 +
 arch/riscv/include/asm/hwcap.h                     |   1 +
 arch/riscv/include/asm/kvm_host.h                  |  14 ++
 arch/riscv/include/asm/kvm_vcpu_debug.h            |  24 +++
 arch/riscv/include/asm/suspend.h                   |   7 +
 arch/riscv/include/asm/switch_to.h                 |  15 ++
 arch/riscv/include/uapi/asm/kvm.h                  |   9 ++
 arch/riscv/kernel/cpufeature.c                     | 162 +++++++++++++++++++++
 arch/riscv/kernel/suspend.c                        |  25 ++++
 arch/riscv/kvm/Makefile                            |   1 +
 arch/riscv/kvm/main.c                              |   4 +
 arch/riscv/kvm/vcpu.c                              |   8 +
 arch/riscv/kvm/vcpu_debug.c                        | 107 ++++++++++++++
 arch/riscv/kvm/vcpu_onereg.c                       |  63 +++++++-
 arch/riscv/kvm/vm.c                                |   4 +
 tools/testing/selftests/kvm/riscv/get-reg-list.c   |  27 ++++
 18 files changed, 500 insertions(+), 2 deletions(-)
---
base-commit: 317c7bc0ef035d8ebfc3e55c5dde0566fd5fb171
change-id: 20240329-dev-maxh-lin-452-6-9-c6209e6db67f

Best regards,
-- 
Max Hsu <max.hsu@sifive.com>


