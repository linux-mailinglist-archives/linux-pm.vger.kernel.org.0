Return-Path: <linux-pm+bounces-27135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671EAAB6C6F
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 15:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1B43ADF35
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 13:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCC2145B25;
	Wed, 14 May 2025 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrPqLSEB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A95825634
	for <linux-pm@vger.kernel.org>; Wed, 14 May 2025 13:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747228598; cv=none; b=QnePp5w2Xms0xUmcnTzvSo93+0yDtEaPfZ1qYXgzKwFXVk5U0oZt2B4fdYugDZIzfayZqKhG7w2WvZkaauyemcX08Zf3jkyekFUfY3ApEErDkUn0VgIxuxz4BvhRM6GjoHJxTm3NklJ5gLdARgsLBDqLFflDH8sqW/rRdjL2acc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747228598; c=relaxed/simple;
	bh=3mdJiBencSNxta3dyF8z2OWbBuH6yjWb2HaJ34mgkI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAAeXAYuFBZvx640pxv1AYwoUwAhyiY1LQLHKGV7t8i11IReMWombwAUF1IHX6yLncSfKYhAZtB7JJRkTwFjtBAOc4ur+AGQ33lPgVZmVepdEr8sVpyBPskFjRlOU4AjwYT53qsNNs5uNs2Y+zHbRVlTx+cBeZaGlyBK2LYbjVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrPqLSEB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d0618746bso52825375e9.2
        for <linux-pm@vger.kernel.org>; Wed, 14 May 2025 06:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747228594; x=1747833394; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6Tc/4nqMXEbm8d6EyQQLonLFnqiRqlfA73rzExd6DXQ=;
        b=TrPqLSEB1ulzx5H2IqgUjA1s0dE/rAadVtYSdnOlCFe4HF0YtMp4e03nReGdflnwMF
         CKJK/ZAQgqutgtchySjvsESFvqFLuSFykcSRpeWCfDbRjZY/29CaclNEwphx5b2ivnBs
         Frz6wIPR6Epna1PrrkmJ5j7j1enJWyLtKTVvaAHFZHBOOKCZbW45v9avFSWq//3V7Uxc
         WzDntQAs7m1XqNRvc4M8OZqx7+b+aCnkmv8RBvCHkbizS2q9qD+9y7wu1cmVzscdsBc5
         RdGD0vvge38IRjk1co4jELpYHmRo5RvlF3ELgjEYUx6Fdi/Qpjyo5jp2kPNsmiAo0xFh
         8vpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747228594; x=1747833394;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Tc/4nqMXEbm8d6EyQQLonLFnqiRqlfA73rzExd6DXQ=;
        b=emt9Jli1yxFSOsSDeVc/OKIbg6j92YJ3wdwaP7gw7nVnZkI3YW4V/Pf201Ekt9btiE
         QcUw/xsA+B/uQvZDhmUHsjGTtC1tK4w3rfWFEpfEQvdNwme6wjjvgYVj43SVDSa3JBCX
         E/REdbAd9HmlOwu5KCVQodIgV1FsinnHpD6OdFycJdjpBGjOcokiFO/zTHz2+kxOcTgg
         Q8H4ThSQD7AqGWvN0+LAcmXpUySwNlg1YEYRc+M+uUgS4V2CUvnL6oMk6ems3hLW8gEK
         gUwOFzLoDUDjy5mvIViVQbXR3TNoluBMq/YjTd/AFz9YMAmQkK4UQPbfxjghS4z3Live
         mpfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCsDpwakonoKJBTvMQ7BUMPxvfvWL8aFc1FoJf/IwH6IQBkyiOPuT4O96ytdgTPW0KrQToen/wgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOlcNIVEE4znCHUXD9uOxYNEtZSGeBQt5URGwwpUzwsjAA6Jr3
	n20R8DWvCw0iaQebtt+8sS0KgQkOS+TlBU5VPXCPO6oqAodLeS94Lh6BaA==
X-Gm-Gg: ASbGncvra62RjiBQrddOfk2Pg7rcPGFAnKM6KwFvczusv2XV5GgsqOMkZKZ5JILFlwO
	jUbvgU9244QyzBNIcnnx81ZOMzjv66Tw8IfrQX6yqqrYleoj9qeuLbdW8hMejKYq+kNTlN0sKvf
	yz/lpWiirWg5fW8PhdsyVho2SdFfb3DypUUbSs2lFM4cz8zNosclzulzayL7s8wuHR16Nb8w6gE
	6VO4qanD+5Nn8tJ5Evbz/LyL888+yN6QNQqLDJLivK4M8bfjpb8M6M29HwXyV9XFWOFZJQM50LB
	gUT857qtQJ8QSAsCHbdMHr06V+4aEECic6or91Ycavaej6pZpGQ=
X-Google-Smtp-Source: AGHT+IE8pnOYRJ/c4cfBs063yTkYwwC4PzsQ7cS9MN+l+gs9yIacFQxXiJfgdSPWX+aNftsTNP45Cw==
X-Received: by 2002:a05:600c:524c:b0:442:e9eb:1b48 with SMTP id 5b1f17b1804b1-442f215f1cbmr26898775e9.24.1747228594244;
        Wed, 14 May 2025 06:16:34 -0700 (PDT)
Received: from Red ([2a01:cb1d:898:ab00:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442f3979275sm30575305e9.34.2025.05.14.06.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 06:16:33 -0700 (PDT)
Date: Wed, 14 May 2025 15:16:31 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Chanwoo Choi <chanwoo@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] PM / devfreq: sun8i-a33-mbus: Simplify by using more
 devm functions
Message-ID: <aCSXr-Hdisg-7jEd@Red>
References: <20250513203908.205060-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250513203908.205060-2-u.kleine-koenig@baylibre.com>

Le Tue, May 13, 2025 at 10:39:02PM +0200, Uwe Kleine-König a écrit :
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Use devm allocators for enabling the bus clock and
> clk_rate_exclusive_get(). This simplifies error handling and the remove
> callback.
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---

Tested-by: Corentin LABBE <clabbe.montjoie@gmail.com>
Tested-on: sun8i-a33-olinuxino

Thanks
Regards

