Return-Path: <linux-pm+bounces-5628-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283508915CF
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 10:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D458B228B4
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 09:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C875102D;
	Fri, 29 Mar 2024 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jfZsineP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCC74CB36
	for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704468; cv=none; b=GP8aWjtLB+AERi8zdX+wTHfA9Pl4pSWBcjMRcVk6UcVRjE8X9gTYWkcWkZFILgXGcm0nAkjx5uHzVV6kxm7Nzk07cKGbEGMbYHRuLbYy3/xjqtT43yT+ZguoqeTh6zns1/s86KzSOktpMvItR22cKEzxmyt5TqKazsihzpgqnNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704468; c=relaxed/simple;
	bh=LSg/rLuOsrxnsspgQ4r75KW0fisxGsUYFmGBfMYsNR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mmDpLch+4b+ERWWWOMCx2f1D82InAqpBfHIx1xCCJLxZadJV/FNVXvk02tFZoVITRUojV+nxVjXvZ234G70+07bqs6O9EChCTd/37gs9v8V9oy6rOAke5+QER3DJwhazw/lk1GsWSHF/WlIfg3zTO41DTTrtVuJkorZYku8f3KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=jfZsineP; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29f1686ff12so1380836a91.1
        for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 02:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711704464; x=1712309264; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36s8w1btdvP+IRdBHf7/8nd9U/EcEkIO6Yh0YtSkXJI=;
        b=jfZsinePGh8GvughMdULBUqVVMU1/IJRkTvq/SnnFQDY0Q+6enwRM+p1Y4Db8388LN
         Ld0i1RVKMNpoau3cAcSqb5TrIJqhYrW7P+fQz3J9IQJwOkKcKowBRgEsvr2lUU4DYjbA
         /0snbQzpo2MYpphrbq8vQGY5i4KqzuiwtPry/z1RnbZD0+6Z7gFRBshffAJ23D5v+uzW
         cxFsXRI/7R2j1NvNuFIxlcuapbcsxuuPFr3lv8UNbBysKwDbWFlx9IMC+SQBuCFDf3vA
         mAtSjLmfnj5tnMuaHSHq+O4ceHaGTfHdGvxbTVd48Jv+s4Ly7qh3TAv1BDpU6+Sp9wHq
         4anQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711704464; x=1712309264;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36s8w1btdvP+IRdBHf7/8nd9U/EcEkIO6Yh0YtSkXJI=;
        b=C2fVZRrynL97TyypTIRBZgDkSJA+DwNgmY3jTs5PBRPjrbmd5Os6NQ2lhIqF8BH/Wi
         iqM5DR2qqzCBiGAEeFG+2jZxLvIJJG0S/thdPTfFyzKj8XSGjU6QLMOkhXaHoh9cj0SC
         5Ojer9Nxdv8mKUU9eGIFHCxGatnOH6uaDYTLYfsCzbkMfyMcoVUvZe/6kRzQhTGBr3PD
         xld4XC93VRE9suy6oqb3BcAXVXLr1LJonj0IHiC/nxerWo4Hw7uxDTePGdLmLL6IVYPd
         GeCm5x7z8oMx6NnL5VbkPrK48z0g8CesuLyF+ZiSAsiNGMSl84Tu41oJCuPjQZBhoucY
         gDbA==
X-Forwarded-Encrypted: i=1; AJvYcCUixp4hGu2nepHkVvNJNE1RiCln8mycuk3M7WQ1wDtO9+XKZB8S+EKhtFI5l7cxQSyCP7ApFlXosluloc6vu775SZ7IGr6cRdY=
X-Gm-Message-State: AOJu0YxSSmDbxLwZ17+GpI6fBC681Dy0XoNDatI6W9RuznTVUFzpfDh5
	dII8YIZ+YUI9HlTVXBWJpXkw1JeyQvZRjeJaiId9p9znOMGI4dz4tdgSN0yfYt4=
X-Google-Smtp-Source: AGHT+IFlwBZNBeq8Vspi+hcWxSywtk3eGAD9nkXigHO0/VIsXQXySmGGcQSPVllJIcGqIgMzGVu2Kw==
X-Received: by 2002:a17:90a:6986:b0:2a2:1012:fbbf with SMTP id s6-20020a17090a698600b002a21012fbbfmr1808164pjj.14.1711704464008;
        Fri, 29 Mar 2024 02:27:44 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id cv17-20020a17090afd1100b002a02f8d350fsm2628830pjb.53.2024.03.29.02.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:27:43 -0700 (PDT)
From: Max Hsu <max.hsu@sifive.com>
Date: Fri, 29 Mar 2024 17:26:17 +0800
Subject: [PATCH RFC 01/11] dt-bindings: riscv: Add Sdtrig ISA extension
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-dev-maxh-lin-452-6-9-v1-1-1534f93b94a7@sifive.com>
References: <20240329-dev-maxh-lin-452-6-9-v1-0-1534f93b94a7@sifive.com>
In-Reply-To: <20240329-dev-maxh-lin-452-6-9-v1-0-1534f93b94a7@sifive.com>
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
 Max Hsu <max.hsu@sifive.com>
X-Mailer: b4 0.13.0

As riscv-debug-spec [1] Chapter 5 introduce Sdtrig extension.

Add an entry for the Sdtrig extension to the riscv,isa-extensions property.

Link: https://github.com/riscv/riscv-debug-spec/releases/download/ar20231208/riscv-debug-stable.pdf [1]
Signed-off-by: Max Hsu <max.hsu@sifive.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 468c646247aa..47d82cd35ca7 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -121,6 +121,13 @@ properties:
             version of the privileged ISA specification.
 
         # multi-letter extensions, sorted alphanumerically
+        - const: sdtrig
+          description: |
+            The standard Sdtrig extension for introduce trigger CSRs for
+            cause a breakpoint exception, entry into Debug Mode,
+            or trace action as frozen at commit 359bedc ("Freeze Candidate")
+            of riscv-debug-spec
+
         - const: smaia
           description: |
             The standard Smaia supervisor-level extension for the advanced

-- 
2.43.2


