Return-Path: <linux-pm+bounces-21057-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE9BA212A0
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 20:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42B23A97D4
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 19:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18591F7905;
	Tue, 28 Jan 2025 19:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uBbrAA+H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4FA1F75B1
	for <linux-pm@vger.kernel.org>; Tue, 28 Jan 2025 19:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738093725; cv=none; b=pGN8vRvYxgZNtPzo1sPAeuQqyA0rBePYZJzgLdtOU+2LojQ9XBG5YshGfs4wTf4l3Ji5CFL3HhMkM6uqAEEuo07Bme7+O3R7nOfWbEh+1G70cDl8qAVk4CBSo5FzfhW9uuR0aZyoatv/fqqw8rS4esoUz6/8OecIOCL7qe7mgFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738093725; c=relaxed/simple;
	bh=EPTfVn7RO7bxt60ecnL9agD4AkZcbKS0/DFOlc9uLaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=d3xjDEIjFIIW+xyDWElzLflK6lS1lb06VxJvAt5ezowr9/nzMRY0EWAbhnhSBuPqikCGFo7JVcpNLJcTnnGPt1j1Qkzn/SVpUXwWSJnhR8cPdWs9fL0GYHtLL68TScQH1RiG22fpVCGAIVvUkKVwMywo2mzuYWpokSFXn7cMPNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uBbrAA+H; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250128194842euoutp01ae7c0c081c77f27cd72472d0fe83aa3d~e8wgRRY5R1604816048euoutp01e
	for <linux-pm@vger.kernel.org>; Tue, 28 Jan 2025 19:48:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250128194842euoutp01ae7c0c081c77f27cd72472d0fe83aa3d~e8wgRRY5R1604816048euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738093722;
	bh=Y2qJNPOZypRXsHO3MOeXcoXxlzsdYgLbcjVG1hzxKaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uBbrAA+HgHU5zA4GmlmKN3hiCeYWbDkVrDa9iqvX8JOMovB8s+lFD5c+qwEr8DnVo
	 hwNjoi1MwwlY65SfZtxr7TwxAxMuwjK8GGiCAvtlQVA9VCnYvJwQDdqbeoLhKjcw5Q
	 LfqGEnNTvN06FF0PtbSyxhxAKazf66WcOvAmGmiM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250128194840eucas1p12316a8c7a0e7753c557a0039898e3297~e8wfIvVOi1988219882eucas1p1s;
	Tue, 28 Jan 2025 19:48:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 10.B2.20397.89439976; Tue, 28
	Jan 2025 19:48:40 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250128194839eucas1p1885da20ddfec840341879c120a21f514~e8wd7luM21987319873eucas1p1q;
	Tue, 28 Jan 2025 19:48:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250128194839eusmtrp24121382b264defa79f495155ba6b26f4~e8wd6zWPb3008430084eusmtrp2g;
	Tue, 28 Jan 2025 19:48:39 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-df-67993498b8b6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id E9.E0.19920.79439976; Tue, 28
	Jan 2025 19:48:39 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250128194838eusmtip17b436b12e07354d608828f7ae9be1e4d~e8wclKrHC0291602916eusmtip1b;
	Tue, 28 Jan 2025 19:48:38 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com,
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	ulf.hansson@linaro.org, jszhang@kernel.org, p.zabel@pengutronix.de,
	m.szyprowski@samsung.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, Michal Wilczynski
	<m.wilczynski@samsung.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 11/18] dt-bindings: gpu: Add 'resets' property for GPU
 initialization
Date: Tue, 28 Jan 2025 20:48:09 +0100
Message-Id: <20250128194816.2185326-12-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128194816.2185326-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0xTZxj2O+f0nNKleFpgfCiRrdEtzq0wh8kXLwxQl7Ptz0y2ubAQqHpS
	2LiYVlSUgIxyL27oHFBULpFZLh0bo4wiHa4rFFQaUKxOS2FhOFpgHXIZ4JBBD9v897zP+3zv
	87xvPj4uvkZu4McnHWMVSbIECSkgWroWrK+VhpbJQx6O7kDd96oxpH+ioVCD0YqhCrOVhxy3
	mzE0MOsm0TejfRQaM2YSyKa9RKGsrkYSOTUOEhnH9RSaUjt46E7bRRJNF5kBaplWkUhnHqRQ
	42wFhqqm9AS60toGUE7+1zzUf2M/GnR0E8h5R42jHM16tNzeSqGntu8IVP5HB4WaJ4p5yKI7
	iFQdXxLhQYz7fjbFTDidBPNz3gzFGOcqCcagGaQYteEWYJrq8knGbmsnmcs9B5ihQgvGfH8l
	g1HpujDm86UQxv3jXZI521wHmNtZ96j3xFGC3UfYhPjjrCI4LFYQV7zUSRx9RJ3sNDqwM6CP
	LABefEiHQsOIHhQAAV9MawHs+VOHc8UMgKaBepIrpgFcepC/IuN7nvQVfMDxVwG8mFu1JpoA
	MM95FludS9Lb4fDVCt5qw5fOJmB2Z6bHBKcrMFi/WIavqnzoKHitxu7BBL0F6rUmTyohHQ5H
	KnWASxgEO37q9Wi8VvimJS3BaUSwp+w3D8ZXNFn6ck9wSOsF0Fxox7is++Di+U3cHB/osjRT
	HA6Ey4YKjMPJcFj/GOdwGjSoLWt4F7RbF8nVMTi9FTa2BXN0BOwfzV67hDe8PyniEnjDcy0l
	OEcLYV6OmFO/BC+oi/4ztWpb1kwZODTWQH0BXtQ8s4vmmV00//tWArwO+LMpykQ5q3wjiT0h
	VcoSlSlJcunh5MQmsPK/bz61zLYCrWtKagIYH5gA5OMSX2G0tVQuFh6RpZ5iFckxipQEVmkC
	G/mExF9Y3ZEtF9Ny2TH2U5Y9yir+7WJ8rw1nsIBNsRHrxWMyP/rWy8RQgkp74HldmDsgsE50
	ujqEl5778K1CcwH50bodo03+te+LBPud0T9Qj3dORlbFRMYeGn91o6Q41ytN/EJPXBV9OrDc
	IsL/Mrw9d644NKLXW+eX9tl89+WT3wZk3Ex9c3MqGogGg+lffej3cX9a+bgoLnLEPfG79uCp
	+rDaw9KgqBnXo+C7xSf2RGzuZbc7DnXYoizpPqpCw7x958KTDNveOfEFl35W+IvLETopC+bt
	Dnx3GY98znw95u+S+K7xtgZsVyponN+j3hYd/mAh2S5ZXicqpXxtZb/ue+fGcEMmuc1yqbay
	6JP2kr3Xa5T849KtNcGuLRJCGSd7/RVcoZT9A7mJXt1OBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsVy+t/xu7rTTWamG6x6rmxx4voiJoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbK48vU9m8W6pxfYLV7sbWSxuLZiLrtF87H1bBYvZ91js9j7eiu7
	xceee6wWl3fNYbP43HuE0WLb5xY2i7VH7rJbrP86n8li4cetLBZLduxitGjrXMZqcfGUq8Xd
	eydYLF5e7mG2aJvFb/F/zw52i3/XNrJYzH63n91iy5uJrBbH14ZbtOyfwuIg7/H+Riu7x5uX
	L1k8Dnd8YffY+20Bi8fOWXfZPXp2nmH02LSqk83jzrU9bB7zTgZ63O8+zuSxeUm9R8vaY0we
	/X8NPN7vu8rm0bdlFaPHpebr7AFCUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFW
	RqZK+nY2Kak5mWWpRfp2CXoZE/8eZSl4xl5xdO89pgbGC2xdjBwcEgImEhe6QrsYOTmEBJYy
	Snw9bgliSwjISFzrfskCYQtL/LnWBVTOBVTzilFi/9cZrCAJNgEjiQfL54PZIgKLWST27qsE
	KWIWWMok8ej/AbAFwgIREo/fe4LUsAioSmxdcYgNxOYVcJB4vGAtI8QCeYn9B88yg9icQPFN
	f1ewQBxkL/Ho7QyoekGJkzOfgMWZgeqbt85mnsAoMAtJahaS1AJGplWMIqmlxbnpucWGesWJ
	ucWleel6yfm5mxiBSWbbsZ+bdzDOe/VR7xAjEwfjIUYJDmYlEd7YczPShXhTEiurUovy44tK
	c1KLDzGaAt09kVlKNDkfmObySuINzQxMDU3MLA1MLc2MlcR53S6fTxMSSE8sSc1OTS1ILYLp
	Y+LglGpgaku9clHyXer3oHcWkWL3/spqRdy/07L40+VNk/1Ka/e6Wa+ZKSY20bmZ3feYybxN
	L4p6zh45pK23537F3CTePdd1ZTtD7d9Kq368LfjnVEqYjoD1ZueL/yZ1HHr9+pv+XIVfTq2e
	C1OZA+QP9J4urHnDtMapM7zk+bFdPMYZa3Nvik158lD0ypelh29PTzksk9S2P+CGzYczt720
	eKfPmt+v5Pw31/flHrXSj8ny1jIV9xWF/jP8yUiKrapSZXuub/Piwb0Kk9g7yRoBfJHxR079
	bfz88YZb6JelyS7f21VChNmMXAsMnxv7x3Btn2OutnG5v+f0I3pxJ4KT975hOii9YdvU/+Vb
	ispLrvCdUWIpzkg01GIuKk4EAFmqttq7AwAA
X-CMS-MailID: 20250128194839eucas1p1885da20ddfec840341879c120a21f514
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250128194839eucas1p1885da20ddfec840341879c120a21f514
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250128194839eucas1p1885da20ddfec840341879c120a21f514
References: <20250128194816.2185326-1-m.wilczynski@samsung.com>
	<CGME20250128194839eucas1p1885da20ddfec840341879c120a21f514@eucas1p1.samsung.com>

Many RISC-V boards featuring Imagination Technologies GPUs require a
reset line to be de-asserted as part of the GPU power-up sequence. To
support this, add a 'resets' property to the GPU device tree bindings.
This ensures the GPU can be properly initialized on these platforms.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index 256e252f8087..bb607d4b1e07 100644
--- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
+++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
@@ -37,6 +37,9 @@ properties:
   power-domains:
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.34.1


