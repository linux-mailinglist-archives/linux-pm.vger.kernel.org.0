Return-Path: <linux-pm+bounces-15989-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5D59A4682
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 21:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AFFF1C224CA
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 19:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55662040A8;
	Fri, 18 Oct 2024 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPPgRW+N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175182040A5;
	Fri, 18 Oct 2024 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729278562; cv=none; b=rhCqpVlGvxSKtfdi9iApuH7BP6/m9N0+6Pgla3/35zlhQJv5lerSlgGPpnrOqJjuOcWrqdcDnO1d3VPqULKfTfxt8HN1MGF5fYE+d9oIags2VQTmmR8Pd0PtSt2mN/1K06+/gC/Tr56tsQoqKsrwCFZHlIdXPlayK+owc6L3KEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729278562; c=relaxed/simple;
	bh=D99S00RyTTISFxr8e+C424y45Q8rUv8zo9O97MdVQnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+oH98LbhHlca1D8ksMROjdPWpzYY+h9I1SRNTvMyQH1IRxrmOEvyW+a+Gw7kO/xgjS/xwU3+9qiErHJ14R6QHE9bXxoBh8xA0oWvl4ZBzSFs9mkkNWjOy1jrC4Ux3R1ppQO1J6zE+uubOVGM3laBzt21a8ieiOxs205tR4wPd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPPgRW+N; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20ce65c8e13so21979445ad.1;
        Fri, 18 Oct 2024 12:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729278560; x=1729883360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tCWiI7Mk5Pc1ToBG0yRJeA7emmBaVqdcvJdezV41wZ8=;
        b=cPPgRW+NqLUSBdTYly8D7mH4DjyCvWptTypxAKuda0+fAoEEurPml6SaFnov1JxlRt
         wiVI3DvoMZ3ycVkP8NqeMQhCtxBx8acEbqF8T5jj5vqpNOXhdvUKRXil3t2oq+svzEPZ
         LJLcL4qWv0eFSSVStwDpIKK1ZaCnAIzM56pu/tJtHmo9Ncu87K/q+OZWKwn1VRtelve5
         p51oPd/kwR0pqMJIan1IyJwAy/kyZiiAvwLgCs1LqkaDgLBZrB0mnm7hqG+/ZRXAFOcB
         5dFp5dIlVLugwTZk1uyZSzrxHO9RDX/mNKln3Qk58QajLVnTmK6618A2JXE0ZMwr8nXM
         D3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729278560; x=1729883360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCWiI7Mk5Pc1ToBG0yRJeA7emmBaVqdcvJdezV41wZ8=;
        b=EFSPKABCPYSAa5iXtnMkBy2IIH6GIV6pj2uhR2ZEH8PBl9APbRL9FDGlEv2r5IT/nb
         8fkbKhAc+3HM2XxWowomNm74vCimcGmwExwJaiSEE8pvmmmectQgvN5MzHXAW80CC1RF
         oyd9tnz90b7q3Q/ySOhm3kQpRUpNNFMXz/UDGN4GyKzk6GsYGdu4UvmO5iIrmjdFivl+
         F+0Sg2PazTCF6S3agAYxnbR5igkABbw9YmBxYne2GYM04ugAYBKn/+Ow25w6K9YKZI3d
         rITi5g5XOsCuBjqqrBrIAM1cAwzPem4ky834htR9eBQoB8eMaaNjpDhABrcHOvjy18YX
         mcPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE4zGPjzvESE0GC2lwzQarM4rDbTYJtypFpoAyl8Uj3y7cLPoNoHs82BizXmmMLuAzg0VTV8TdqDdenx6U@vger.kernel.org, AJvYcCUoX7ew7OkdThWBirB+oCaHe6xtkBOi/nNnHbTq8x8ySTz7PJ+A3E/gsrLN7xWAu4X286W3n3UqOomygAQ=@vger.kernel.org, AJvYcCVWf+YeMy0NBMrIpfE47w9WgAKiJ2jNl8fjlxaKrmIkGQusvArrz+FalGvlXET8kST7uok05RmTXzk=@vger.kernel.org, AJvYcCXc+r0DrKnVI41gKR9WETHKUSxdHCKz1mryNoF3jrSe3yd/UkvI6X5S0rpQIZNySRdMl3DkSW7sjfvi@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr8+S+c4azvyz5OXbPVv+6O0bBk01F9IaJVI9cK2xrA5v6Mjus
	eb/WmvM+WMiF7YtyWMPDZrctKLaN3XMJWq/JAiRfl1f4br9Lc9mv
X-Google-Smtp-Source: AGHT+IEruX+cxyVH+gwEEsGDweblTcIgnGhNv3IgeQH5Htuac5wGmq7mHQTOxWYmy6TV37BjA3ZgmQ==
X-Received: by 2002:a17:902:c94e:b0:20c:dd71:c94f with SMTP id d9443c01a7336-20e5a95110fmr44504275ad.41.1729278560033;
        Fri, 18 Oct 2024 12:09:20 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:351c:e27f:10e5:484c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a71eae8sm16052525ad.45.2024.10.18.12.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 12:09:19 -0700 (PDT)
Date: Fri, 18 Oct 2024 12:09:16 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Yassine Oudjana <yassine.oudjana@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	jason-ch chen <Jason-ch.Chen@mediatek.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	Flora Fu <flora.fu@mediatek.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 6/6] Input: mtk-pmic-keys - Add support for MT6328
Message-ID: <ZxKyXFZFFNwD6Tsg@google.com>
References: <20241018081050.23592-1-y.oudjana@protonmail.com>
 <20241018081050.23592-7-y.oudjana@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018081050.23592-7-y.oudjana@protonmail.com>

On Fri, Oct 18, 2024 at 11:10:48AM +0300, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add a compatible string and related data for the PMIC keys on the
> MT6328 PMIC.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Feel free to merge with the rest of the patches.

Thanks.

-- 
Dmitry

