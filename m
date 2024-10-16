Return-Path: <linux-pm+bounces-15744-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BB49A03AB
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 10:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42E81F21E52
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 08:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5783D1CC14C;
	Wed, 16 Oct 2024 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkyQT3Pt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D21E1B2193;
	Wed, 16 Oct 2024 08:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065949; cv=none; b=cdrV+G+lXcnU9UYQPEHa14aexFU3VhAJZkf6ZLD5DDvod1XHevaH5qej7bC36sQDszyB+fCrx43s2QcUC5/8ldIgDd4MRyg99ovB0doY9nijz6zbvbqIl9tIWmbX6fq4Rtgna/+MQZl5zJpW2YDFrEBTCvlfO8te5y0FDhFEr5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065949; c=relaxed/simple;
	bh=sipAjpeBbrrp16bNbYnn0kiRQmETvkOf3Pt/RzvNzNQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rzXuS//KLqP4u8aLIvChBZ2KbVgDWPOfX9HVPO4U4pgP1/EcQmcY7xhLRzUEiRhDOZk3MpvwyqZhBbNY+Az/GHnotLWDAWn0TDmOZ3HwtUn8ZzHxVx9jzF6sHmoEnN5NM7Ji22OKG4rl+D8ot7PP25dwC9y8OmICFLp1HPdxqZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkyQT3Pt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDE1C4CEC5;
	Wed, 16 Oct 2024 08:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729065948;
	bh=sipAjpeBbrrp16bNbYnn0kiRQmETvkOf3Pt/RzvNzNQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MkyQT3PtTV4YokJbpmI+HkLnZzOtaaiO2iDHzI8ShWFDueovgMkJWeC0epTAVMPTn
	 ep1sWBou6QL3nvaMk7gyPJK8xcqsIzhwAinHOm60Xbw1bUnTkXewq9aZChAeRfwQI9
	 8Wym6RmXNsVq0lUsTw4oG7zyS7za83Dy3+0GOD6UDOJboaXTxAGTY0/S7ETsuzYQvu
	 pZ4xAXaDlk0EkCW4Pr5H01XJ4q/TZI64k7aWAESDdVnx7Xpu1+Edrzfzv0R2N4n4Q5
	 vNiXLDBASTco0VfGmJLwtrjkIAfqdQO4KjjVFGW54pvxagHLTIv5iRiW+UaoDHiozJ
	 oHB9JpFuidbmA==
From: Lee Jones <lee@kernel.org>
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, 
 Macpaul Lin <macpaul@gmail.com>, Chris-qj chen <chris-qj.chen@mediatek.com>, 
 MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
In-Reply-To: <20241004030148.13366-1-macpaul.lin@mediatek.com>
References: <20241004030148.13366-1-macpaul.lin@mediatek.com>
Subject: Re: (subset) [PATCH v2 1/2] dt-bindings: mfd: mediatek: mt6397:
 add adc, codec and regulators for mt6359
Message-Id: <172906594464.1151212.7462336994993240007.b4-ty@kernel.org>
Date: Wed, 16 Oct 2024 09:05:44 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Fri, 04 Oct 2024 11:01:47 +0800, Macpaul Lin wrote:
> Since MT6359 PMIC has been added as one of the compatibles of
> "mediatek,mt6397.yaml", the sub-device node of "MT6359 PMIC AUXADC",
> "MT6359 Audio Codec"  and "MT6359 PMIC Regulators" should also be
> contained in this DT Schema as well.
> 
> This patch includes:
>  - add 'adc' property and $ref for 'mediatek,mt6359-auxadc'.
>  - add 'mt6359-regulator' to the compatibles of regulators.
>  - add 'mt6359-codec' to the compatibles of audio-codec.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: mfd: mediatek: mt6397: add adc, codec and regulators for mt6359
      commit: 5bcecfcaa6d1d4ea1b29082ed1fd077ba4cccb55

--
Lee Jones [李琼斯]


