Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4492F890
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2019 10:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfE3IaV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 May 2019 04:30:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50351 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfE3IaU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 May 2019 04:30:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id f204so3363173wme.0
        for <linux-pm@vger.kernel.org>; Thu, 30 May 2019 01:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pIqrbsE6/Nv/138vVdlcEQnoXvw/3uCQiUSd/l1oIaY=;
        b=WNzLuakp6v+NS3a1DLSFrmIvLHD6xt5KYh89N/BBFGcfFuqn6v/SmL3/CPB1hwnKwc
         1MkyyG3oDfJTKcko46AAXnIyQjAWLAC376Vm3Iy63ERu8/uA2laK0XPL2jBiIBsCR0Th
         8MQ7qpxmk/6MryDUDXTACXQCEy6VWCTAT1LR+0H/z02//3cgjTYq5dIwMgmNeiE8C9dj
         ED9W1VKpx5AoxqBBId0hzEl3/aRLWxWBiCN80Szbbo7tUNLMTX/BC7yTsVH5iSFUVXz5
         hWlxLILq1kkgZH7sufxBQQZdBor03W89lX+2Tpi6aKRxfunD9O0nkNuj2Xg1dQDRPQXG
         K7fQ==
X-Gm-Message-State: APjAAAU1Tz+gic78KD0Oe0vMoZPqL6uqN8O2Y9oQgmkrwlDNXcfbNn3t
        M6NTXENEf1uNQ7WD/UM1iS1AwQ==
X-Google-Smtp-Source: APXvYqxguQuxTuphnJ9ISpnJqaH4xcMLu4CCyeeLtDHqpdu4VJX+hsaHIz6Atqsiq1kkBiYITPXGpg==
X-Received: by 2002:a7b:c043:: with SMTP id u3mr910083wmc.56.1559205017089;
        Thu, 30 May 2019 01:30:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3da1:318a:275c:408? ([2001:b07:6468:f312:3da1:318a:275c:408])
        by smtp.gmail.com with ESMTPSA id y8sm1688765wmi.8.2019.05.30.01.30.15
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 01:30:16 -0700 (PDT)
Subject: Re: [PATCH 09/22] docs: mark orphan documents as such
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Matan Ziv-Av <matan@svgalib.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, kvm@vger.kernel.org
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
 <e0bf4e767dd5de9189e5993fbec2f4b1bafd2064.1559171394.git.mchehab+samsung@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ea534992-07ff-15d8-e48b-5fde37c88f73@redhat.com>
Date:   Thu, 30 May 2019 10:30:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e0bf4e767dd5de9189e5993fbec2f4b1bafd2064.1559171394.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/05/19 01:23, Mauro Carvalho Chehab wrote:
> Sphinx doesn't like orphan documents:
> 
>     Documentation/accelerators/ocxl.rst: WARNING: document isn't included in any toctree
>     Documentation/arm/stm32/overview.rst: WARNING: document isn't included in any toctree
>     Documentation/arm/stm32/stm32f429-overview.rst: WARNING: document isn't included in any toctree
>     Documentation/arm/stm32/stm32f746-overview.rst: WARNING: document isn't included in any toctree
>     Documentation/arm/stm32/stm32f769-overview.rst: WARNING: document isn't included in any toctree
>     Documentation/arm/stm32/stm32h743-overview.rst: WARNING: document isn't included in any toctree
>     Documentation/arm/stm32/stm32mp157-overview.rst: WARNING: document isn't included in any toctree
>     Documentation/gpu/msm-crash-dump.rst: WARNING: document isn't included in any toctree
>     Documentation/interconnect/interconnect.rst: WARNING: document isn't included in any toctree
>     Documentation/laptops/lg-laptop.rst: WARNING: document isn't included in any toctree
>     Documentation/powerpc/isa-versions.rst: WARNING: document isn't included in any toctree
>     Documentation/virtual/kvm/amd-memory-encryption.rst: WARNING: document isn't included in any toctree
>     Documentation/virtual/kvm/vcpu-requests.rst: WARNING: document isn't included in any toctree
> 
> So, while they aren't on any toctree, add :orphan: to them, in order
> to silent this warning.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Please leave out KVM, I'll fix that instead.  Thanks for the report!

Paolo

> ---
>  Documentation/accelerators/ocxl.rst                 | 2 ++
>  Documentation/arm/stm32/overview.rst                | 2 ++
>  Documentation/arm/stm32/stm32f429-overview.rst      | 2 ++
>  Documentation/arm/stm32/stm32f746-overview.rst      | 2 ++
>  Documentation/arm/stm32/stm32f769-overview.rst      | 2 ++
>  Documentation/arm/stm32/stm32h743-overview.rst      | 2 ++
>  Documentation/arm/stm32/stm32mp157-overview.rst     | 2 ++
>  Documentation/gpu/msm-crash-dump.rst                | 2 ++
>  Documentation/interconnect/interconnect.rst         | 2 ++
>  Documentation/laptops/lg-laptop.rst                 | 2 ++
>  Documentation/powerpc/isa-versions.rst              | 2 ++
>  Documentation/virtual/kvm/amd-memory-encryption.rst | 2 ++
>  Documentation/virtual/kvm/vcpu-requests.rst         | 2 ++
>  13 files changed, 26 insertions(+)
> 
> diff --git a/Documentation/accelerators/ocxl.rst b/Documentation/accelerators/ocxl.rst
> index 14cefc020e2d..b1cea19a90f5 100644
> --- a/Documentation/accelerators/ocxl.rst
> +++ b/Documentation/accelerators/ocxl.rst
> @@ -1,3 +1,5 @@
> +:orphan:
> +
>  ========================================================
>  OpenCAPI (Open Coherent Accelerator Processor Interface)
>  ========================================================
> diff --git a/Documentation/arm/stm32/overview.rst b/Documentation/arm/stm32/overview.rst
> index 85cfc8410798..f7e734153860 100644
> --- a/Documentation/arm/stm32/overview.rst
> +++ b/Documentation/arm/stm32/overview.rst
> @@ -1,3 +1,5 @@
> +:orphan:
> +
>  ========================
>  STM32 ARM Linux Overview
>  ========================
> diff --git a/Documentation/arm/stm32/stm32f429-overview.rst b/Documentation/arm/stm32/stm32f429-overview.rst
> index 18feda97f483..65bbb1c3b423 100644
> --- a/Documentation/arm/stm32/stm32f429-overview.rst
> +++ b/Documentation/arm/stm32/stm32f429-overview.rst
> @@ -1,3 +1,5 @@
> +:orphan:
> +
>  STM32F429 Overview
>  ==================
>  
> diff --git a/Documentation/arm/stm32/stm32f746-overview.rst b/Documentation/arm/stm32/stm32f746-overview.rst
> index b5f4b6ce7656..42d593085015 100644
> --- a/Documentation/arm/stm32/stm32f746-overview.rst
> +++ b/Documentation/arm/stm32/stm32f746-overview.rst
> @@ -1,3 +1,5 @@
> +:orphan:
> +
>  STM32F746 Overview
>  ==================
>  
> diff --git a/Documentation/arm/stm32/stm32f769-overview.rst b/Documentation/arm/stm32/stm32f769-overview.rst
> index 228656ced2fe..f6adac862b17 100644
> --- a/Documentation/arm/stm32/stm32f769-overview.rst
> +++ b/Documentation/arm/stm32/stm32f769-overview.rst
> @@ -1,3 +1,5 @@
> +:orphan:
> +
>  STM32F769 Overview
>  ==================
>  
> diff --git a/Documentation/arm/stm32/stm32h743-overview.rst b/Documentation/arm/stm32/stm32h743-overview.rst
> index 3458dc00095d..c525835e7473 100644
> --- a/Documentation/arm/stm32/stm32h743-overview.rst
> +++ b/Documentation/arm/stm32/stm32h743-overview.rst
> @@ -1,3 +1,5 @@
> +:orphan:
> +
>  STM32H743 Overview
>  ==================
>  
> diff --git a/Documentation/arm/stm32/stm32mp157-overview.rst b/Documentation/arm/stm32/stm32mp157-overview.rst
> index 62e176d47ca7..2c52cd020601 100644
> --- a/Documentation/arm/stm32/stm32mp157-overview.rst
> +++ b/Documentation/arm/stm32/stm32mp157-overview.rst
> @@ -1,3 +1,5 @@
> +:orphan:
> +
>  STM32MP157 Overview
>  ===================
>  
> diff --git a/Documentation/gpu/msm-crash-dump.rst b/Documentation/gpu/msm-crash-dump.rst
> index 757cd257e0d8..240ef200f76c 100644
> --- a/Documentation/gpu/msm-crash-dump.rst
> +++ b/Documentation/gpu/msm-crash-dump.rst
> @@ -1,3 +1,5 @@
> +:orphan:
> +
>  =====================
>  MSM Crash Dump Format
>  =====================
> diff --git a/Documentation/interconnect/interconnect.rst b/Documentation/interconnect/interconnect.rst
> index c3e004893796..56e331dab70e 100644
> --- a/Documentation/interconnect/interconnect.rst
> +++ b/Documentation/interconnect/interconnect.rst
> @@ -1,5 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
> +:orphan:
> +
>  =====================================
>  GENERIC SYSTEM INTERCONNECT SUBSYSTEM
>  =====================================
> diff --git a/Documentation/laptops/lg-laptop.rst b/Documentation/laptops/lg-laptop.rst
> index aa503ee9b3bc..f2c2ffe31101 100644
> --- a/Documentation/laptops/lg-laptop.rst
> +++ b/Documentation/laptops/lg-laptop.rst
> @@ -1,5 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0+
>  
> +:orphan:
> +
>  LG Gram laptop extra features
>  =============================
>  
> diff --git a/Documentation/powerpc/isa-versions.rst b/Documentation/powerpc/isa-versions.rst
> index 812e20cc898c..66c24140ebf1 100644
> --- a/Documentation/powerpc/isa-versions.rst
> +++ b/Documentation/powerpc/isa-versions.rst
> @@ -1,3 +1,5 @@
> +:orphan:
> +
>  CPU to ISA Version Mapping
>  ==========================
>  
> diff --git a/Documentation/virtual/kvm/amd-memory-encryption.rst b/Documentation/virtual/kvm/amd-memory-encryption.rst
> index 659bbc093b52..33d697ab8a58 100644
> --- a/Documentation/virtual/kvm/amd-memory-encryption.rst
> +++ b/Documentation/virtual/kvm/amd-memory-encryption.rst
> @@ -1,3 +1,5 @@
> +:orphan:
> +
>  ======================================
>  Secure Encrypted Virtualization (SEV)
>  ======================================
> diff --git a/Documentation/virtual/kvm/vcpu-requests.rst b/Documentation/virtual/kvm/vcpu-requests.rst
> index 5feb3706a7ae..c1807a1b92e6 100644
> --- a/Documentation/virtual/kvm/vcpu-requests.rst
> +++ b/Documentation/virtual/kvm/vcpu-requests.rst
> @@ -1,3 +1,5 @@
> +:orphan:
> +
>  =================
>  KVM VCPU Requests
>  =================
> 

