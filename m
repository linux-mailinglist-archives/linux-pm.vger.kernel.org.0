Return-Path: <linux-pm+bounces-31722-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCBDB17C3F
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 06:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F481586A39
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 04:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1997C1E3DFE;
	Fri,  1 Aug 2025 04:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VPdcEacv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEC11E3787
	for <linux-pm@vger.kernel.org>; Fri,  1 Aug 2025 04:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754023896; cv=none; b=NyB8in0YkKNH4c7UQ8YLb335rvvR5z0gvnmY9+Rw0oGlj6a4IkvrbhPJWAmwziid2hq29QrQjQp58DV8UQydfcHyW5MuFx0h+dCYW1aetPi335ynybS4FdQy/odspmyEK20co8OJSsf78gC0NngkrfjdBZONvmTcj7TO8FWp7+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754023896; c=relaxed/simple;
	bh=0Yp8+sGL3lRpm7HC5BKRhWpXDbqCyYKzOoJSMIzIH6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GY1trL5R4oxNHrEYMXoTOQv21Isg7mOCZs5vipPKq9RdA7sPO8SM78MF5T6/Mu3qKxiYJU1pKG9mkC0gpEULdv7UnsNyk8BlMtmoL3VZ3HKmBHYDamZWJfR/UnOqfQN+4Vtwq5mX5EWsPv6Flbe/b0nhCgtcs6bRyNLnlXIaX04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VPdcEacv; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e33d36491dso120754085a.3
        for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 21:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754023893; x=1754628693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Yp8+sGL3lRpm7HC5BKRhWpXDbqCyYKzOoJSMIzIH6A=;
        b=VPdcEacvb0J3I+qM24Fbj6Aplae59t373d35IfjIwhB/yVlDughoKsORp970wX6q2w
         VMFdbdUBlUzD1xv68dYBiCOqpEw04SIsQss0+NxFoJ3b4n6zWkozAB8uD8VVwaI2DnoI
         c0L++qeTKWCQXuFK66WdrigNyFGDWZcLs45WY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754023893; x=1754628693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Yp8+sGL3lRpm7HC5BKRhWpXDbqCyYKzOoJSMIzIH6A=;
        b=RIakx2VF+mGEzpWCBn6lB8/e7pls3ga1vOJYG2xXiStDDWoPn+eCSl6ZjeTGs/BzXW
         Za6LomsR1VJ/DEn3Whg5Aq6lLJEi5+gsRyZpEG3FJC7iwZwUb89HXg5rINh9fs4WCxZS
         VKrg9J2jVl48bFR4vm+kXhUUGudBAFRM/gpFgnUEjMRS+lK36PpHbZu1d1+OqDRVZGW+
         ujqALTo2T0y2rP+b+B2h7QX3BAQW0+KX/8RaPCCTq3+gBA9BU1M9QZx13OzTBlBsdCc+
         phpbOnLUd+Ho0oar8mt75JMvEzfTvzWM8w//nGG8IjjcuwzjzyTwINWIy8qOEDWYzUI3
         6tYw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ0zevbwG4UoweZBDlPITvMMxK9ZRUAIu/8MmU6X4RsF/dRoq0zIvV4EzHSEX/JV0mg23h6yGqKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb1JAUQN+qvfapKjots/dji3fdZJZuKkLTJHCAVzjAT9nbHAWE
	8CxGBQ4DiZDkIXn05gIAIzjC1zoAljw6smyL1TDjoBtyKUJxKJTHGV6pgmSUtmJX7W/91S+Hp3u
	yHLo=
X-Gm-Gg: ASbGncvx6jm9b9nc9SO//PMzcSKjNuvrRawQVuo+o3as0kX4te7w2mY3v0rUYFminm7
	LtoSnq9jrYgQ8/Vif3M5N3TAnE6XIBLvtpWuGZGVU+uyoSBVme4HjfzXw6IBDIcuouVP2fkJCyS
	Q31UfSgIgKYYxJSql1R5lfaF/VMyDIxxL9ZluGt1743npUh1+ljru06CPJU5JcYoNhzpCTJF1RX
	IxgQQY3WTYdxMWUJM9FHJJzQHwtELJIx2XGtQY2zybzD2WTkgQfIQl9Xq3a4LVxhPiVMklllfxC
	UsoM9856xBOJVckuJmXwDhY71zDUtt5D+RcNNWkTUbJDoDG/wn5JzbPYhzhXaKJQYOe7j/yT3lL
	li1NLil42kPPjh74oplheY0F+wybL+UFsFfagoLCSzFa1z4TaEXHcOfcE5r3Bv4+cHOu46nLJ
X-Google-Smtp-Source: AGHT+IFhD4y7zW4NLs2m04X9HoWlR0ieTaiAzK2dimpaDuAet1c7LnhGNpyWMOjw0yt1J1kdhn6Ybw==
X-Received: by 2002:a05:620a:1a13:b0:7e1:f16c:16d6 with SMTP id af79cd13be357-7e66ef78e04mr1414482985a.8.1754023893079;
        Thu, 31 Jul 2025 21:51:33 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f752aa5sm176036885a.75.2025.07.31.21.51.32
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 21:51:32 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4aef6114494so15809121cf.0
        for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 21:51:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhQz86KK9/RVTsF16GF/PkDUzS4uGfM1ko7d7rtUnvlpCETX/vTfItG0x+G30fQSfguQsg4y6e1g==@vger.kernel.org
X-Received: by 2002:a05:6122:521a:20b0:539:345c:f229 with SMTP id
 71dfb90a1353d-539345cfaf8mr2385080e0c.6.1754023496106; Thu, 31 Jul 2025
 21:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC=S1njcFhyY6+dT2MHU02ZsLDq+k_vAVv==bWuoGt3KA18PHg@mail.gmail.com>
 <20250731101441.142132-1-laura.nao@collabora.com>
In-Reply-To: <20250731101441.142132-1-laura.nao@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Fri, 1 Aug 2025 12:44:19 +0800
X-Gmail-Original-Message-ID: <CAC=S1ngjmk8-C0H2Nii4NXE3wsL1dYLQp-PXafG0=oaOVsYgmA@mail.gmail.com>
X-Gm-Features: Ac12FXx2cQ8dN2cbGqrj1qjUfxVx4elX2aD-gscg8zxkv2Gb7ghx-fdTpW8_Hzc
Message-ID: <CAC=S1ngjmk8-C0H2Nii4NXE3wsL1dYLQp-PXafG0=oaOVsYgmA@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] thermal/drivers/mediatek/lvts: Add support for ATP mode
To: Laura Nao <laura.nao@collabora.com>
Cc: andrew-ct.chen@mediatek.com, angelogioacchino.delregno@collabora.com, 
	arnd@arndb.de, bchihi@baylibre.com, colin.i.king@gmail.com, 
	conor+dt@kernel.org, daniel.lezcano@linaro.org, devicetree@vger.kernel.org, 
	kernel@collabora.com, krzk+dt@kernel.org, lala.lin@mediatek.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
	lukasz.luba@arm.com, matthias.bgg@gmail.com, nfraprado@collabora.com, 
	rafael@kernel.org, robh@kernel.org, rui.zhang@intel.com, srini@kernel.org, 
	u.kleine-koenig@baylibre.com, wenst@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 6:15=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> Hi Fei,
>
> On 7/31/25 06:25, Fei Shao wrote:
> > On Wed, Jul 30, 2025 at 11:40=E2=80=AFPM Laura Nao <laura.nao@collabora=
.com> wrote:
> >>
> >> MT8196/MT6991 uses ATP (Abnormal Temperature Prevention) mode to detec=
t
> >> abnormal temperature conditions, which involves reading temperature da=
ta
> >> from a dedicated set of registers separate from the ones used for
> >> immediate and filtered modes.
> >>
> >> Add support for ATP mode and its relative registers to ensure accurate
> >> temperature readings and proper thermal management on MT8196/MT6991
> >> devices.
> >>
> >> While at it, convert mode defines to enum.
> >>
> >> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> >> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> >
> > It's not visible in this patch, but a heads-up that I see
> > lvts_ctrl_start() also depends on whether lvts is in immediate mode. I
> > wonder if anything is needed there for ATP mode e.g. a new
> > sensor_atp_bitmap.
> > Feel free to ignore if this is a false alarm.
> >
>
> Thanks for the heads up - the bitmap for ATP mode is the same as
> sensor_filt_bitmap, so the function is already working as intended.

Acknowledged, thanks for the clarification.

Reviewed-by: Fei Shao <fshao@chromium.org>

>
> Best,
>
> Laura
>
> > Regards,
> > Fei
>

