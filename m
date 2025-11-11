Return-Path: <linux-pm+bounces-37788-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E18C4DA40
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 13:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46C0C4F78E5
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 12:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F633590B5;
	Tue, 11 Nov 2025 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k1XGru6Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA8E3587D8
	for <linux-pm@vger.kernel.org>; Tue, 11 Nov 2025 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762863287; cv=none; b=JgmtiVoxcFZWX1DhykyaUrwGEqltjYBUUa4Fe1LIe/lOtqeMdBrWfGGB6Cl4WuOW1Gov6nWzU7MSIkEKWvxffrNuD5ngpO6ukH1n8mLnl+XNd+UTYhHSec2xxDo2clJdJf0e+wuv1PLsssEyUSi6Mu+GeDshfGFSE+/8lRRO7HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762863287; c=relaxed/simple;
	bh=Cm8DAlkq7cNB7eXK9B6TWRGj+2lGvxbjXLY72bWBOVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXwH50wt2n4JH2MJ8+D5LW0k8iKaWN8VSuKaNnGYdocOXTfL6ILFj/ptrgMwyGnWDAsIWEpa/dYFME3kulBYnH495LY+aX6f2Ec8I4OabnFu8z4n+nQTNMSK1PlZQvvxafyQ8hdIZ6RH804CKE205DFpvs5xZpSXFJzgCIW0MHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k1XGru6Z; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7869deffb47so39802327b3.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Nov 2025 04:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762863285; x=1763468085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfV4LvtG02pkcZqmjoIHQyje6DoWRqzhd0WA5bSXwjM=;
        b=k1XGru6Zb+68rKFkN+KDaFu9/e0bdsQkd0JiJFW1ra9VxV6KbmLGJK3ohRK82IEpiP
         z1jbWu0smIW9hcgRORquFXHpeRteIgZc+tPZqGG2SYBiMDYbXpbKlr8x5JWM/Yiwf09p
         aTresM6PDHBE6E5GldMSyJjAIK6/onJ0ZtWWWcWIyH3KiBbcEhQjTXUIb57C/BQNAYTI
         v2nbphel5etTasaYb4vzQFrSC0R4oezrndpfDvsJJkRI0M041S1d+9eBJYL/1mT22POI
         Wgec/rvojtsUOANrrnZf5aZ8CoBjJIQz8uwzp3K0EQmdI5hre76aUsGMdAYzauBePjUm
         j19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762863285; x=1763468085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qfV4LvtG02pkcZqmjoIHQyje6DoWRqzhd0WA5bSXwjM=;
        b=hNqVpvhMPxmjoPteNJSFngmyx4KYAWJk0atCXrIQwTKZ0/D2VxMkMO6Fwc2PAbY8KP
         8bSqItx3MNuEwu6W0Sq7ZFGpBdxNEXvkwDQ5i1UdM72ODHgF/up5ZLoKdCTLoR0JeNqm
         Cpa6+wgk65yvbco12+6Gb7vOmCVWAtRIQsZrZtEWVrhbdgBGU+PMVGNg3Rvfwufch2u9
         9iR/5ARMCtEPq1WOXTLtCcGwm/58SE6jaSmttqXGVriMsXEhJS1JBJHjpfHlb1C2bj9E
         9ouskauYoIntd/C2ISCZFObSew/G08UaZEhkOMyGM0ABe9p2aKUTdoWsPnDvS4yeonAa
         /7Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXDlA2XwaQbQoLDBX75N0DxIiAtyDURjbjv3HSzrNExNLsgpq4ryXcFnQoDfonxdwLepMtuDlXG8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjJ0wGsVIKrv3N7rLwJKfyEWoe9vaVxCu6yUCoWx3jMseiXE1R
	rWruN3ONEHdNFVm0E5u4CDH4j4WoiWEqvSI8UNY6giU2RMB2A1JmsYOs/kadmosgQcK22Dn96QY
	9zXZWjl9fA6w+hv7T2kSwA/apBdt5kB0baschCCHvPw==
X-Gm-Gg: ASbGncuM0prqt0gNElKrHpfDxhsWGQV500w+VsTpERn/sLFUML0GZn36o18B2UcDjsS
	FkvVQ5mkE1DuYFmxz65+veTqT4CZwEeCqquUYrdeUqIwttJbjqmwJn5pfcX3WGCX7Nh+8Z+B0bu
	U+MVikmkVWuTFMWToZTQL1NyGJcLDyU5d3eTeIEvDln3xiicm7XoiusSt3W5xN/2O3eYedW05ZM
	b3GkD8G98kmvwt1fHtBigzN/LTgnsDhUAi/im+/bjGEp86boj4rpgox35FQaHv+rv08rH8=
X-Google-Smtp-Source: AGHT+IGzBCxItR5F/c1tm+Myz9Jj9DUiAidCyH8elbUYYK5ed+2hTXSOvUuPWDsQh1/9f6VcI8TQwGH/v+rs7F/04hY=
X-Received: by 2002:a05:690c:4d09:b0:786:4fd5:e5df with SMTP id
 00721157ae682-787d541af70mr109409167b3.39.1762863284723; Tue, 11 Nov 2025
 04:14:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111060009.1959425-1-rdunlap@infradead.org>
In-Reply-To: <20251111060009.1959425-1-rdunlap@infradead.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Nov 2025 13:14:27 +0100
X-Gm-Features: AWmQ_bmQmQW8jMVRgz5D2rAorGCeiuZeYk9-nDFNHjG3RHER32SRPEoKMrN-RAk
Message-ID: <CACRpkdZFmdicvsr+yhmXLHTJSSrVdoZuVwdRm_3_pC3QibicwQ@mail.gmail.com>
Subject: Re: [PATCH] power: supply: ab8500_chargalg: improve kernel-doc
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 7:00=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:

> Correct "bad line" warnings and add descriptions for missing entries
> to avoid these warnings:
>
> ab8500_chargalg.c:173: warning: bad line:  is set
> ab8500_chargalg.c:179: warning: bad line:  increased
> ab8500_chargalg.c:247: warning: Function parameter or struct member
>  't_hyst_norm' not described in 'ab8500_chargalg'
> ab8500_chargalg.c:247: warning: Function parameter or struct member
>  't_hyst_lowhigh' not described in 'ab8500_chargalg'
> ab8500_chargalg.c:247: warning: Function parameter or struct member
>  'ccm' not described in 'ab8500_chargalg'
> ab8500_chargalg.c:247: warning: Function parameter or struct member
>  'ac_chg' not described in 'ab8500_chargalg'
> ab8500_chargalg.c:247: warning: Function parameter or struct member
>  'usb_chg' not described in 'ab8500_chargalg'
> ab8500_chargalg.c:308: warning: Function parameter or struct member
>  'state' not described in 'ab8500_chargalg_state_to'
> ab8500_chargalg.c:773: warning: Function parameter or struct member
>  'di' not described in 'ab8500_chargalg_chg_curr_maxim'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for fixing this Randy!

Yours,
Linus Walleij

