Return-Path: <linux-pm+bounces-16667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EB39B4E18
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 16:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA191F24455
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 15:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85ED1957E9;
	Tue, 29 Oct 2024 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TROZt4ie"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FAA194AD5;
	Tue, 29 Oct 2024 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216054; cv=none; b=QrOKSTGwmW8U+lRoQ2e/OERVC0AdkklHHGi+dZABmXEBT8FlncYiFHCN8afXVljKxnoCjKRGdUeD6OLbVdn9gGz8/UO0il/HureNU9I3WcuYhySbHBHcWaDYQt/aaz4ku4XDTCsvO8F7pf3bz5lxBNnX0QqiISLlrpvRvh1MEDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216054; c=relaxed/simple;
	bh=wSiMyiVZXJZVYcVK725oDVvDfADpdfHKIkl1o+Px7DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLjo9tpo/BJNKL5Tsfc8O9YMdlpK6GUlHtE3SydODUk5BE5G/lo8oVQScrjqv52BxrryZ6/aLYJ3gjopxalrAtyZtqtO99ytnjRibV2pQjVn8pqRxWJQ9PimRxneCV6QRHHt66BmxZgI5h9jsPIFjDpvfLat/ObkHVdF6eHYAXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TROZt4ie; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b1505ef7e3so359821085a.0;
        Tue, 29 Oct 2024 08:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730216051; x=1730820851; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NvKHclZp8wng408kUlr3zIB/tjSz9AoBIcuqjDo9UYE=;
        b=TROZt4ieQGfLrcMR5V9WZKeZ0CRThVncWeZ01p0dw9+/zurwqNUcNkj4rMhkhbN9pQ
         mdMJUgU9l0tylT/KS+Y2phqoj/ZukfcLS0X+WdJD9kXuk32v97+Qa6X2UjsIWYdLbhvG
         KPkVF92/zYOz2YXJumJldzNK0QPR/s6LCDkmNc+H/j28Et7ob9dozM+B5UDlDrLuHfRm
         rkcIxNlNFUpdbP9n8LTx7ouBI2OZPQXvSURfcZkfQV38OgHTQGv/3Ewsgj/7mBW3/dAR
         abM0qh5tl4XdmgFZMy2CQQrTmjlTiZ5BM0x9729dH68DKDhmuvZD1mWmxC6rX+3rhpf0
         Cq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730216051; x=1730820851;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NvKHclZp8wng408kUlr3zIB/tjSz9AoBIcuqjDo9UYE=;
        b=IHK2Qk+NTTqT5Mmi9fDYspVkm5mrkN2uGrBaPOLW/CRRa3mj5FryuxqdQuLLZpWEJV
         gomGR2k9LZiAvKyM0742rIB0LMBgTjG5Q5TXDN75jnYxQDP3+bjNobS41GM7A/EIXAi2
         ymroFhnwYYbAna4kH1+hHACUujHjx9g6yC7GWjNwq9q5RcrE/iXwY2pEES9aQKnP4jSE
         8LWBVMdSok3HVBu8tEThwarBf1wxWHsCQ/tkYo77PAzFBJxTjTgZAFvtnyfDSNncU3cN
         ir7B541B/gvP+zrBzcsmVrEnZPBTMszd+yduSp+7gzA7OC8ZSkXtcogzHnaYufuOY+VC
         5MVg==
X-Forwarded-Encrypted: i=1; AJvYcCUZKj9eACJ+8F0CsNMWDHBY9yXd+fpD48bOXl3LjQQH5+3muxjVUrK71EuO0CufKZXaXy9TUcRqwF0=@vger.kernel.org, AJvYcCV/4uW4r83yAjmvtLSI92VOCSQqkKIxT3zfPgywg+CgCqGwyfGFkWuc7UfqvAE7o0Q+HSBK800fnE9nOhbM@vger.kernel.org, AJvYcCWGQCE+I4hKiypP9CLHxeJjm0i4O/Ep3ppAKd4JDhxTAyc+jFkWxesmY5nN6makhxH4RQnDN5Cm/s7wkfrK3H+f4Fo=@vger.kernel.org, AJvYcCX5IJbvbjRxvgWE4EDvb604g4I1uhhTo1gyD2eB3OmB7rRr+fPWk9F0+GtyFynB3X7bzci6YKDvnz7qHqI=@vger.kernel.org, AJvYcCXckzKZ+MySy9tThsh/AzxoWy2v4o/mwqQ2j01MytJYrhMNnb5eLjA1UCfBTu7Jd+8qX+/Wb560YGKmPGv3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4BXcmDvvRoJk1Pr+uXttZrZi00iNcHYUuOOIzs2KA3HCIpjEh
	gNXpuACt65uT288t5hrgk/WyQrMSDClZ7MXpPCA/vFWyNVx1+f49
X-Google-Smtp-Source: AGHT+IFEK1Lj+KgPR7qF2SZIPbGWb1EluUys2IzUezoVVlhCBBeUjMF3gYTnyYnzfqeZ8MKMdnnF7w==
X-Received: by 2002:a05:620a:4456:b0:7a9:b8dd:eb96 with SMTP id af79cd13be357-7b193eff5camr1988254585a.30.1730216051027;
        Tue, 29 Oct 2024 08:34:11 -0700 (PDT)
Received: from crash.wifi.local.cmu.edu (cmu-device2.nat.cmu.net. [128.2.149.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d292c88sm429507285a.30.2024.10.29.08.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 08:34:10 -0700 (PDT)
Date: Tue, 29 Oct 2024 11:34:08 -0400
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
	Huisong Li <lihuisong@huawei.com>,
	Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	Mark Brown <broonie@kernel.org>, David Wu <david.wu@rock-chips.com>,
	Jianqun Xu <jay.xu@rock-chips.com>,
	Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Izhar Ameer Shaikh <izhar.ameer.shaikh@amd.com>,
	Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>,
	linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	linux-mediatek@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] soc: Switch back to struct platform_driver::remove()
Message-ID: <ZyEAcHVC3gXujNa9@crash.wifi.local.cmu.edu>
References: <20241029074859.509587-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241029074859.509587-2-u.kleine-koenig@baylibre.com>
X-Clacks-Overhead: GNU Terry Pratchett

On Tue, Oct 29, 2024 at 08:48:58AM +0100, Uwe Kleine-König wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/soc to use .remove(), with
> the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
> 
> On the way do a few whitespace changes to make indention consistent.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---

for LiteX,

Acked-by: Gabriel Somlo <gsomlo@gmail.com>

Thanks,
--Gabriel

