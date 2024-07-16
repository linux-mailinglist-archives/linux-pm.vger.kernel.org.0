Return-Path: <linux-pm+bounces-11133-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D880C932003
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 07:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A7F281D5C
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 05:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EEA10A11;
	Tue, 16 Jul 2024 05:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h50l1E50"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F8DB67F
	for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2024 05:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721107325; cv=none; b=UwHhKswyocmlbyKmcybEcmuyvaXpkZkyXfLgpyiUEH2HdiQ2KwRk0X2KhbYWsZV4Zmlz8s3a/RUaVPRdHyskifUNvV3TGCgzUHCfct3GOnO85YEtFPRvN8Qc3gCT84dfsn2FUwj6E6K3+SsY6Pml3j3CYDneGbzKgO6P34SDQ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721107325; c=relaxed/simple;
	bh=q7htRbTViAynUe1KUvBKJdXCuUBYVcPiUmif37E0la0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpIG8IzYuECG3CPxTiNH5AzZW0llLJjgfgjiqRVfqafpCd2gEVXCpb8a0WnWCCl7jZda1wkg9u83UUvdKTMSRbBu5EBld1hn8Apr8zmGCK9GRJQIIm+l3Gm0kPUR9d6GlkCrfcRN2fjWWFjV386EwDkRsTvyJgEhHNJJVTHQjBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h50l1E50; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-78135be2d46so3765385a12.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2024 22:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721107323; x=1721712123; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nCJcSlsxzmcGU/ol+ZphLepYn+zSneU2YnwQbi1SKTk=;
        b=h50l1E50aH2wPsA498Dn3f+S9K8XVSyRRjwESJmjOh1ln4jWfVali9dkzwA2Osw8VT
         870G142gaLS3875inWTT6ndzzuTjGP9Iees/7+mJdIhc6C/88VAInksPHXbP/mmi0EPK
         ocQH84VU65P1GASktLJxnKGU17/ohS/EDrSd+xdVAaCNy11fHXBYfi83WQ+F5+7PQyRL
         lWddqynGJMbsKVX1bJggf2g78ICH84Gm6/7I+xPSw23XA6o4UZtPn5aL9dEWmq+xKi/s
         VCkpJwpv51pCFxV98uv5AqIhVxHUXnVK+ebBLkye3n5HMTA9VMT8U5rd2BLLFcSYDZ3z
         e0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721107323; x=1721712123;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCJcSlsxzmcGU/ol+ZphLepYn+zSneU2YnwQbi1SKTk=;
        b=MGXAVi4NZeDwvZBV4zw/LTr6G3sV14N2TkmpjDHkBVu6AnugCWPLrf4e4G3fNb5So/
         3QFMB9VjTq5poyHHS0MmuJv39PTD83224dlilOhM2ggL8feyTRiF1nQFFDyROaNq9pcJ
         MVfCvQBlj2u8Zt0Ywi/fZMgSD/h2r7GFuT/spDfbqLRfnWsi2DaHHPQbkMCkw18nXIcm
         uMzkv79yididDO7L301nnBN40tXvFOs4chK0GUaFWU1GM6zOVWlwWnU65QZtpowyUTcD
         vXhu4Q5Vo9eenQ6PTPYVz1zqKie/rq9i9V5JTS2m2Q00JB3q6Hgm+VQdxW6elxIzyfFM
         byhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrGWop9kJEErg888d0LXcMAppOzkZsldaaObZTfryUaPmSWpUtvcTFzYQhe1xhSTZbLBkOPQA8XLPQxW4QqJio39DHdHtb4C4=
X-Gm-Message-State: AOJu0Yw/SkJUgCJkswioUBQK8/flLmvJhp6zIQPBhWKnONjQepg+H2Yc
	XsmDYV+2RrGAy+rZiMkxI7Y/+x21eD+WQHwwnkxAClodAHbp0ByxUyen8Hi+7g==
X-Google-Smtp-Source: AGHT+IHYY+XYEW0QviFVSL2Wxv+cytzps03AGaTXPes1VQeCqPvZwa/jm9JROaB1vSRLz5c8LKdaTw==
X-Received: by 2002:a05:6a21:458a:b0:1be:c1c0:b8de with SMTP id adf61e73a8af0-1c3f12978ecmr1126946637.42.1721107322938;
        Mon, 15 Jul 2024 22:22:02 -0700 (PDT)
Received: from thinkpad ([220.158.156.207])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd41aa2bsm7358175a91.31.2024.07.15.22.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 22:22:02 -0700 (PDT)
Date: Tue, 16 Jul 2024 10:51:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [GIT PULL] power sequencing updates for v6.11-rc1
Message-ID: <20240716052155.GE3446@thinkpad>
References: <20240712091008.14815-1-brgl@bgdev.pl>
 <CAHk-=wjWc5dzcj2O1tEgNHY1rnQW63JwtuZi_vAZPqy6wqpoUQ@mail.gmail.com>
 <CAHk-=wjcO_9dkNf-bNda6bzykb5ZXWtAYA97p7oDsXPHmMRi6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjcO_9dkNf-bNda6bzykb5ZXWtAYA97p7oDsXPHmMRi6g@mail.gmail.com>

On Mon, Jul 15, 2024 at 09:29:34PM -0700, Linus Torvalds wrote:
> On Mon, 15 Jul 2024 at 19:17, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Hmm. Let's see how this all works out, but I already found an annoyance.
> 
> .. and another one.
> 
> On my Altra box, commit 8fb18619d910 ("PCI/pwrctl: Create platform
> devices for child OF nodes of the port node") causes annoying messages
> at bootup:
> 
>   pci 000c:00:01.0: failed to populate child OF nodes (-22)
>   pci 000c:00:02.0: failed to populate child OF nodes (-22)
>   .. repeat for every PCI bridge ..
> 
> for no obvious reason.
> 
> FWIW, -22 is -EINVAL.
> 

So we did see these error messages on non-CONFIG_OF platforms, and a fix was
merged as well with commit, 50b040ef3732 ("PCI/pwrctl: only call
of_platform_populate() if CONFIG_OF is enabled")

But apparently, the fix assumed that all CONFIG_OF platforms (selected in
defconfig) have 'dev.of_node' populated. And your platforms being an ARM64 one,
has CONFIG_OF selected ARM64 defconfig, but uses ACPI instead of devicetree. So
you don't have 'dev.of_node', which is a valid configuration btw (we failed to
spot it). And in other places of these of_ APIs, we do have checks for
'dev.of_node'. So for this issue, below diff should be sufficient:

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 3bab78cc68f7..abe826bb5840 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -350,7 +350,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 
        pci_dev_assign_added(dev, true);
 
-       if (IS_ENABLED(CONFIG_OF) && pci_is_bridge(dev)) {
+       if (IS_ENABLED(CONFIG_OF) && dev->dev.of_node && pci_is_bridge(dev)) {
                retval = of_platform_populate(dev->dev.of_node, NULL, NULL,
                                              &dev->dev);
                if (retval)

Let me know if it works, I can spin a patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

