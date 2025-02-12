Return-Path: <linux-pm+bounces-21946-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DDCA3224C
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 10:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F8A3A8234
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 09:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DA120767D;
	Wed, 12 Feb 2025 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBcWMfJP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E4C1F0E47;
	Wed, 12 Feb 2025 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352831; cv=none; b=EvPWQGeMpH2IujI2s5hhJLsPp8VIPov7rN32n2bfBG5Afmo6zp/hBAQGC9e0uzyb9eyEmDsIMeXZm2nx/FsSRY7eNrnkTmZsbymCcQAFWZyzHYHdQHjXGDqANTirsaY5DY1PJBg8+09PypKrbSP0qdE1LJVAt1TYCH4MhAnnVMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352831; c=relaxed/simple;
	bh=28ZrG67VYrx3D1mHBQEW/lHYcFEAj3xmmeyTtjgZ7YA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=svhEBzyTJ6jD6jwCTDC7XoEirV1DrHJ2CN/QINC3XOqSjeAL/Fus2NnedUbKHUN8sbJN7ABDjyZoSFtlBjKi0fAxD1clAG7vVwBy0+e2oO+C4jbfMVUfsTuR/B/B0xFbBI3WCfMXg8K2RKlivhlIde1fPt8lHOjijG46UDx7p/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBcWMfJP; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5de4c7720bcso8024526a12.0;
        Wed, 12 Feb 2025 01:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739352828; x=1739957628; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=28ZrG67VYrx3D1mHBQEW/lHYcFEAj3xmmeyTtjgZ7YA=;
        b=hBcWMfJP/j+iyFlvdQpdum/NHs2XbBXH4PgIh4+3avm0rAibz/ckI/qCO0DZDZqMpY
         Am98uyfwYtUzfCyMlTlJQ/rJyfDfrCyBwQGWEg7hqD7ruPC1tUfkPKX5nqAe2X1BH/RB
         26HXmE10Pmejv/wVkT31ppSdneB7ZfGYDG7k/3ZLmvMg5wD1e3QYseLbf+af98EiDsIe
         riOlfm2VLtALYNM8XV0mZ12q+YRac7NU4oMLrkrN8piqC/MvTgKwgDmMwMhsun/Uhzfh
         4Kub55JyT9Uf2IxaoU/E8OptIihUGx6ZefU93UwpM8kMRns5BMgywydq+yI4SccE9rXf
         uUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739352828; x=1739957628;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=28ZrG67VYrx3D1mHBQEW/lHYcFEAj3xmmeyTtjgZ7YA=;
        b=HPwCBvw5D2oCnInOU5k/cNokxUx4vXjLcP6mELLIAeH2mdf5EXvP/DyA0ea7jKl2wQ
         fAix6ZDqH529SB1vtBM5cOE9g1oXWwfGQAWKNcrruU43MVmpoG5L+uH+VSnSf3A88hPy
         IBRgPuXfG3XcWUfGKmY6vJIC2XmvHtGDrmjy4XsI6thgNf0WXh4fB48E9nKSBWlgz1Ia
         Ra/3SP4lDa4W2L7GmWaL4ytsyilpqTDk0BlHP0CUH6mAJLN/+rCHmqHGwWaqLefNIgY2
         PjwU0OWgIDZ2LjwYJZOH4ss0gSLg5o/8aKk0WZ6VCcwNIxaVLOSzVRrrMaoiky3G6ggR
         XX+A==
X-Forwarded-Encrypted: i=1; AJvYcCUuCMZEFf3uemE+FGWxzwchSSTwU2cC2oMDA3VP5fhgdAOBpV3DS3I7HZXXDvv6EkORDv0EbiUsRrGz@vger.kernel.org, AJvYcCXkmz2LXQlqV2ucdTHRbbVZW5IU2xRhE7yqLJzXFa2l6LVKFM0Yxb2AFH2FOOGhtvHfgcN8T9SuTDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFpbSMNXmpM9FbPVM+BUnDp+hB4dcMtN2CJcsHBeeT0G/2Vx5b
	lNoMtYJbDX0iUDUsUEfPrh0Luw6fhDxNeYFH6ZSUH66W+orVpQT7
X-Gm-Gg: ASbGncsQ29xRsj80QSMKapMkX9vdIih+/XFwqUp+sebCfBr5DFVowSj2uIPa0c4LVfV
	cu1hBf2702oioGjUKIli4+c9vrILxHV/wSkSPhKj1dQHv0Gpi2jlTbYWZh/6GXEGvqdOwihsql+
	BT0niP2AU9Dm/IJuoQZ7Mn67LUTY7FHcLusytBI3s1EQjlDcMX9D4Zk0m5E5o70fC+FCfc1iZT1
	3v9m3u/X5e0C5eVTWs7eXgjMdtFmA83emw9f6qqhz3waxdtBBeXRT502jbSOXiVX3sIEevQf7kn
	ozFPeayjms8gUWx1ybr5Zs/5QRmRq0L2
X-Google-Smtp-Source: AGHT+IHpqQvjQqIwPaFAzknlkp4GoatkNSlei54PmBgAGgJZumwHx7ny/2UY0zjgf5S9YxNNAfvIdg==
X-Received: by 2002:a05:6402:2344:b0:5db:f52c:806c with SMTP id 4fb4d7f45d1cf-5deadde0351mr1663917a12.20.1739352827684;
        Wed, 12 Feb 2025 01:33:47 -0800 (PST)
Received: from giga-mm.home ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de51877083sm8949195a12.32.2025.02.12.01.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 01:33:47 -0800 (PST)
Message-ID: <479c4ac407207c093e9e7b46cc18fb254f2ca74c.camel@gmail.com>
Subject: Re: [PATCH 00/10] arm64 support for Milk-V Duo Module 01 EVB
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>, Yixun Lan <dlan@gentoo.org>
Cc: soc@lists.linux.dev, Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto
	 <inochiama@outlook.com>, Lee Jones <lee@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, devicetree@vger.kernel.org, Haylen Chu
	 <heylenay@outlook.com>, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org
Date: Wed, 12 Feb 2025 10:33:43 +0100
In-Reply-To: <prrsy34bv6xskxu7afgmpdwc7lefdh7l2gtm2ejzcwk74zh6lr@23x3llxy662z>
References: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
	 <eoeyutuu4mrpsu7snkk5ll6kmm4344qsgbnncss6gerlcvvea7@usuf5v7w5ffp>
	 <77c0db160bcaa7c2a68c04a0d33a561b2834f764.camel@gmail.com>
	 <ccadcdf720d6b1055165f1404fafca9b1c6c54f7.camel@gmail.com>
	 <prrsy34bv6xskxu7afgmpdwc7lefdh7l2gtm2ejzcwk74zh6lr@23x3llxy662z>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Inochi!

On Wed, 2025-02-12 at 08:29 +0800, Inochi Amaoto wrote:
> > Thanks for your hints!
> > I've completely missed the RTC driver in progress [1].
> > I will provide a patch registering the reboot handler on top of the dri=
ver
> > as soon as it's accepted.
> >=20
> > [1] https://patchwork.ozlabs.org/project/rtc-linux/patch/20240428060848=
.706573-3-qiujingbao.dlmu@gmail.com/
> >=20
>=20
> As far as I know the RTC patch is no longer maintained. Maybe you can
> pick it up?

I can try... If only I can make it work...

> The patch states can be found on:
> https://github.com/sophgo/linux/wiki

Thanks for the link!

--=20
Alexander Sverdlin.


