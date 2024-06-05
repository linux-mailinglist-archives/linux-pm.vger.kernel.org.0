Return-Path: <linux-pm+bounces-8629-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ACE8FC929
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 12:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4C61F24057
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 10:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DE518FC9B;
	Wed,  5 Jun 2024 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Byc2XsjF"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F03A1946C5;
	Wed,  5 Jun 2024 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717583644; cv=none; b=Nxgj7qygYcHSgqBy1NSYGYBT5HpPY9QQ87IihSzFkRzD5D5CytKAoviE1skNPuDI1LfC3zgSWGetRe+ZmTOdb8d6OkoMe45xkEBBezt33XNeWTFzMVjSHm9jnZLB96H8Q4ZZc5uPKjOsvR3ZZziHrgYSRi1cNq9GU3xpgaLmFsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717583644; c=relaxed/simple;
	bh=eH24vgsLERbd3MYpYzbhRI8kWxjPs+cAWp3PbPHeY0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ngwgs6FSjX0+ADBscPISmKDGFFEGyIu5E3zea4iLwQLhe+rC6x2vvmukGEXZu26EGnwh6RgEWpcQov1Msjl9lKg3VokILbsMesrSAQADduf9pCFtuvy/mAX00/+xE/8BZG0vU4sNvfgAVcivLvF38+2b4nlIQ0TSET9JsGN5ZPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Byc2XsjF; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717583640;
	bh=eH24vgsLERbd3MYpYzbhRI8kWxjPs+cAWp3PbPHeY0g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Byc2XsjFNOtmoxmeq1t4/Y6lFk8XI9w58HPODiFSKd+q6R26KtgR7ooUWEd2ERRzS
	 vHrHxs2/hWI++7mhxHeq6zvUIpUQSOvrEy7XpT+5Y6WcxrJ8T2KsTEWRPnX8lvckd8
	 bo0OC1Z39tBMPzR/hct3JWzf/xzzJkI0whMl4Bdf/VPFwxz47PxjNVqeYybm+kmqV1
	 p6Zz+NZxcVq/jqtk4yq/CI1yfegntDNo6Q/53WFkDtl7QkUJxTLBGxxhfspDUzFrwp
	 hCmASjDRKawD/PalbuCdzhHYeXjzpzg5/+TsCbV3Erc6c4C4DDODBD1JvPtwn4veTZ
	 2KUfygeDK8PDQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2602437806BA;
	Wed,  5 Jun 2024 10:34:00 +0000 (UTC)
Message-ID: <7a5679f1-04a9-490e-ad9d-8f7e706c90cf@collabora.com>
Date: Wed, 5 Jun 2024 12:33:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Return error in
 case of invalid efuse data
To: Nicolas Pitre <npitre@baylibre.com>
Cc: Julien Panis <jpanis@baylibre.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240603-mtk-thermal-calib-check-v1-1-5d6bf040414c@baylibre.com>
 <af024ad1-93f6-4d7a-b139-7eb2fa12eb81@collabora.com>
 <359n7s98-08p8-177q-n51s-33rs215soqq2@onlyvoer.pbz>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <359n7s98-08p8-177q-n51s-33rs215soqq2@onlyvoer.pbz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/06/24 18:33, Nicolas Pitre ha scritto:
> On Tue, 4 Jun 2024, AngeloGioacchino Del Regno wrote:
> 
>> Il 03/06/24 14:06, Julien Panis ha scritto:
>>> This patch prevents from registering thermal entries and letting the
>>> driver misbehave if efuse data is invalid. A device is not properly
>>> calibrated if the golden temperature is zero.
>>>
>>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>>
>> Fixes tag, please.
> 
> What should it refer to? This is arguably a robustness enhancement for a
> defficiency that has been there all along.
> 
> 

If that's been there since day 1, the fixes tag should be the day 1 commit,
of course.

I see that as an important bugfix and not just a robustness enhancement, as
SoCs with uncalibrated LVTS would *not work*, as the kernel would shut down
the system before even loading the userspace.

Regards,
Angelo


