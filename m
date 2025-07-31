Return-Path: <linux-pm+bounces-31682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5381B16F7A
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 12:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0C8175229
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 10:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D25C2BE041;
	Thu, 31 Jul 2025 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ATmu3VSX"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E1C2BE035;
	Thu, 31 Jul 2025 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957676; cv=none; b=kECOgCY8Ch+2IbTPCcSdZIi3a0+84cBeGOINhB0oliOrtw1KwBBe9sqITI+vwIgJ/ccl7K06gWSPZlqOAYW8e+WWSVdSq21hOoG+hL8khDfpZj4lPCewrk4dO25r1RASnvVo7Wb/nt9ralXfHTCfXqgoxUraPe5cAr+4YYPognY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957676; c=relaxed/simple;
	bh=dnZjKRCbKVsKnQZ0apVq2Lv4BunDXwUPUKqAx1JmXY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=abKfe8qR7Awvcog/DL1TfR+lKNtovrSdn4E7sOMuxHipkSequyh7w91UtzuySR281L87hqep1T0vtkKVQ/Pp6ACIQY3lndaTt4zXYapZLWn1XutJZ2XKoJ2Nft6W/JxA6z41tlwuOOO3iwThim2gFSnxb2OytrmP0fcTbhWRO2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ATmu3VSX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753957672;
	bh=dnZjKRCbKVsKnQZ0apVq2Lv4BunDXwUPUKqAx1JmXY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ATmu3VSXbzmFgfERV8e6Eu09Yb59Km6Ykr6zjqidJhxo8lYfAjorCqIYjaanz1Xc0
	 SDTTZwne3FbduuRoAV8Y/xwDpdV6BK5JzzkqzlEW7Ie6hljRkQu6DKHGiCSBo1nkUm
	 BIWUana48yyrDcO3OgtfYzQOUIGzQZJqmqDVJDHN462wFB1GT1rsPysz/22CzIhtLB
	 YvgID2t64hFdwfPzDT6p1PyUv4JrsZburd1XaKV3dCjkJS1V8UrZ2Mx26uKLFiVC8q
	 uHeVH839HFlFeTHR87ZH9CwNcNUu7fQKhOIoWTLOhyOaxCpSdpICjfqJF+T1r8cTQt
	 cL2PGkX+pmnog==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:e229:d0be:3141:7dd2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 82F5617E0A49;
	Thu, 31 Jul 2025 12:27:47 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: robh@kernel.org
Cc: andrew-ct.chen@mediatek.com,
	angelogioacchino.delregno@collabora.com,
	arnd@arndb.de,
	bchihi@baylibre.com,
	colin.i.king@gmail.com,
	conor+dt@kernel.org,
	daniel.lezcano@linaro.org,
	devicetree@vger.kernel.org,
	frank-w@public-files.de,
	kernel@collabora.com,
	krzk+dt@kernel.org,
	lala.lin@mediatek.com,
	laura.nao@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	matthias.bgg@gmail.com,
	nfraprado@collabora.com,
	rafael@kernel.org,
	rui.zhang@intel.com,
	srini@kernel.org,
	u.kleine-koenig@baylibre.com,
	wenst@chromium.org
Subject: Re: [PATCH v2 9/9] dt-bindings: nvmem: mediatek: efuse: Add support for MT8196
Date: Thu, 31 Jul 2025 12:26:50 +0200
Message-Id: <20250731102650.145641-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730235451.GA1911689-robh@kernel.org>
References: <20250730235451.GA1911689-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Rob,

On 7/31/25 01:54, Rob Herring wrote:
> On Wed, Jul 30, 2025 at 05:21:28PM +0200, Laura Nao wrote:
>> The MT8196 eFuse layout is compatible with MT8186 and shares the same
>> decoding scheme for the gpu-speedbin cell.
>>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>> ---
>>  Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
>> index 4dc0d42df3e6..455b96c1e1f4 100644
>> --- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
>> +++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
>> @@ -25,6 +25,7 @@ properties:
>>    compatible:
>>      oneOf:
>>        - items:
>> +          - const: mediatek,mt8196-efuse
>>            - const: mediatek,mt8188-efuse
>>            - const: mediatek,mt8186-efuse
>
> You just broke mt8188 as it had 2 entries and now has 3. I think 
> (based on the commit msg) you want to change 8188 entry to an enum with 
> mediatek,mt8196-efuse and mediatek,mt8188-efuse.
>

You're absolutely right, not sure how I missed that.
It should be:

  compatible:
    oneOf:
      - items:
          - enum:
              - mediatek,mt8196-efuse
              - mediatek,mt8188-efuse
          - const: mediatek,mt8186-efuse
      - const: mediatek,mt8186-efuse
[...]

I'll address it in v3.

Thanks!

Laura

>>        - const: mediatek,mt8186-efuse
>> -- 
>> 2.39.5
>>


