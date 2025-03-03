Return-Path: <linux-pm+bounces-23410-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED61A4E3C1
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D0127A42F6
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 15:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439B925523E;
	Tue,  4 Mar 2025 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WOZ908gj"
X-Original-To: linux-pm@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF43255228
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101977; cv=fail; b=DItYcea5WXmPsAz1iRwXYs2kPasX6I8XxKSYjxvolDZ3ABThJoOBrt1nvi/Ab+HzSscsbc55r52dOyhiK63x0PYmByA8Hsdqw4erwyfu7H53nJ4K9aOarGkQbBPCe9r4kQ9CJqizFzmWZ3CLoDCJ72ZfYxwB6L1a2UEASogVCLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101977; c=relaxed/simple;
	bh=ni5SGlo5xgdJhxHcTY124nLqtYOiHKk1Lf1qmfk753M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6RltHChU1IA1MbUe3EJqLZ8HfYNbzJXQEjy1YEPy/Bi+CNRzokIYdjYh0LocaMqzy0K4ntepxZEbJ52bBW/0kwLbG4BtbMu7T7gxV6u5haHmpxxuynWIrzn5RphSktA6vPoH9cUoczyAW5TRvoyOvXyMJixxWCnDwMXEQ4CNzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WOZ908gj reason="signature verification failed"; arc=none smtp.client-ip=148.251.105.195; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 0C66E40F1CFB
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 18:26:14 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=WOZ908gj
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fbM4LdyzG043
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 18:23:43 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id E53EC42745; Tue,  4 Mar 2025 18:23:34 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WOZ908gj
X-Envelope-From: <linux-kernel+bounces-541505-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WOZ908gj
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 6D4F441C22
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:15:41 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id F0FA12DCE0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:15:40 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8438A3BBC9B
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01AF1F4288;
	Mon,  3 Mar 2025 11:07:40 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763FA1F419F;
	Mon,  3 Mar 2025 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000058; cv=none; b=P8nFGNM0STUYfAPp1ThcsFjm4PRSJ2qvZJmdmzyB07yMGJ0Nqj+YJBNR7xSqWkuSIZyxignZia0Qsg1QhcIGu2i4n9KIrQDBEUVkqxPQOFGEvxLtV6QXtZ/WDKuC6R7EgG1VVz/Z8dIko8e2fK+6uYvZjoNy9Mho3OUIb7sZwZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000058; c=relaxed/simple;
	bh=OolUssdw8s+8uO15m+LPb/DPhu9schaohRHKsJq3xZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uW0WAyHPfjUwAq4hPxHYQa4biaQOOiVYJGynGlzCVjbKiJwfp6Aw94vpOtUj9uw2XhwVCKKVlTU7OlY8k6t4Pw4NuZ1k3d+litkph67DbXyv9nYgazqMidLoJDStd3kyF/hbpUSmoZGMnyuf/2cJe3MZkg094m56bs3+3ImYFGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WOZ908gj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741000054;
	bh=OolUssdw8s+8uO15m+LPb/DPhu9schaohRHKsJq3xZ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WOZ908gjvJNY5AxQz60w31MW//POXd5kyBYLJPfJ87zyLdTB6yH67yQzLaYUyHvn4
	 eShfpI4106nlQsia5YLTCg77KfjSmeSK/aiZwGfZ2O99KD5QRbSq8Up5QqVPatfdiO
	 UcJ0O4BDgWO8JR1CQulmRSofD5ud2GNBiSobqnvBkfFkRKYTT0tZWeNyf4ljQqXKvr
	 q0deYDK67my6KHJBMEQ7ofn8NM/K7vm/nuG5yBuFJNmxDycYciGdlvcUjae83WHnH8
	 ITy2W1sgLrqdn9XB44gH0xjLNV5JR8DBMaO+LDy64isf9K//lXojMAw6T3bkFKCbVN
	 6mXp9MotsY5tQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8AAFA17E0881;
	Mon,  3 Mar 2025 12:07:32 +0100 (CET)
Message-ID: <3ab8b2a3-b9de-4c1e-b650-2892be8fc8c9@collabora.com>
Date: Mon, 3 Mar 2025 12:07:32 +0100
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/20] ASoC: mediatek: mt6359-accdet: Handle
 hp-eint-high property
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org
References: <20250302-mt6359-accdet-dts-v2-0-5bd633ee0d47@collabora.com>
 <20250302-mt6359-accdet-dts-v2-5-5bd633ee0d47@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250302-mt6359-accdet-dts-v2-5-5bd633ee0d47@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fbM4LdyzG043
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741706663.82918@GQo+RyJvG354DyqKOJDT+Q
X-ITU-MailScanner-SpamCheck: not spam

Il 02/03/25 17:30, N=C3=ADcolas F. R. A. Prado ha scritto:
> Now that the dt-binding was introduced, the property that governs the
> eint polarity is a boolean called mediatek,hp-eint-high, while the
> current code handles a u32 property called mediatek,eint-level-pol.
> Update the driver handling accordingly.
>=20
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>




