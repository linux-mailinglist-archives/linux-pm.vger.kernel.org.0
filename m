Return-Path: <linux-pm+bounces-16103-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EA39A6A1D
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 15:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8491A1F2494D
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 13:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6AF1F891C;
	Mon, 21 Oct 2024 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DkhESxST"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C99B1F427B;
	Mon, 21 Oct 2024 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517143; cv=none; b=uRGx6fwXcc/o3LRi7+iEgKVI6soeHTMjec5xw4dfel54yA2IFUOYZd1/wwsKvpykUp04jrAIMHV37kb4G6s/95vkXGCsLH8ScVhxe+jx6pdgSGCwlyJV26XsSg21TfcOZXmlujXjYISQ3IZQVTnqNQZScU9V/6cMfO4z+b/NKlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517143; c=relaxed/simple;
	bh=gpfJV/J4XAJzXROwT21rmERu+KudR+NkEeezem1wx7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bdo3Xnb+l5raqOdKwIuSL2REGVwpRjnVDabq9KXxuK9p0WtEhzM4o0TLkKObxNMJWJ4oQ+o8CEo55qS7G+mbLTTHD4nYcT/B3gEes3aXjO6OkcBLSqY27r6n6J+UIFxZfSlmG6OqipYFeoZ8SIBHPo7axCJD1+If/clyctfer+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DkhESxST; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729517139;
	bh=gpfJV/J4XAJzXROwT21rmERu+KudR+NkEeezem1wx7g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DkhESxST6R8Xa4W1xZkzow/DuKu/6IEgyOACCxg13bWiWa54UsFYkoGPuyiutlAyh
	 hO6uBa68dH133v4N58WdAYtjUg0Ak1KqlrZn+KpNqFWPfBe7sBos3kG4WT1h1oiadz
	 dvlqyA2h++S+YSXArVWZq7MdNbnV+bOh9dxOJwK3h9UKsI3gGEZ1+TjGTdKprno7EX
	 HQxMAmWgG4LfO7Ic43Iu6RwQ0PmNXjDmTA/IA/U57Nkwilb93ijT+0J2bi4QVEYb6D
	 WoIraize3GEnWZb3k3cDPKghAIZmpz+NHYiHd2gYBM9WtpJFoZ3od+PD8IIMOmDlct
	 SWPH8vUhLDxTA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 908F817E3616;
	Mon, 21 Oct 2024 15:25:38 +0200 (CEST)
Message-ID: <9a1d72b0-f545-406a-b827-5ce082c706a3@collabora.com>
Date: Mon, 21 Oct 2024 15:25:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: mediatek: pwrap: Add MT6735 compatible
To: Yassine Oudjana <yassine.oudjana@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 jason-ch chen <Jason-ch.Chen@mediatek.com>,
 Chen Zhong <chen.zhong@mediatek.com>, Flora Fu <flora.fu@mediatek.com>,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241018081050.23592-1-y.oudjana@protonmail.com>
 <20241018081050.23592-2-y.oudjana@protonmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241018081050.23592-2-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/10/24 10:10, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add a compatible string for MT6735 PMIC wrapper.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



