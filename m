Return-Path: <linux-pm+bounces-21916-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70218A31A09
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 00:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE423A1FE1
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 23:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FFC27181B;
	Tue, 11 Feb 2025 23:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yLp7Sbyl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1E0271806
	for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 23:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739318286; cv=none; b=NdKySu48wPnp8DbTVqhWYT3KViV9YdiVer7zWHGz+EmUvkceZLblVO8PxZLyXt3CBMCuri8QyR8829qAchJVWKDIDaXcolU3vvxnlOJMDYFDnKBhiGy2eP5BAUD6KRBYW8Gbc3WPwCN+04ux9lhwPNx4ml71uO/WOdQYYLa1U6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739318286; c=relaxed/simple;
	bh=RE+aHUIVuDPsDQj42j/fwrw4kpBxa9lJz16JhCXTAlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9/qAtuWje/GqfX3s2nqHX05cakOiy7jDDmFi9xz/jx6FGoqfDR9AqYqctSU1jbmvIJyk5DKj9GmBa5Tdr5p0W73HvA/5Y0wtsAnnSWsI0FNwDQm+oUe+Ji/yAg3jAXEpvyXvY6Lpwk81DrgHeSpebXWE7AccHqhMA9ttllbEN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yLp7Sbyl; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5450622b325so3548495e87.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 15:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739318283; x=1739923083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LX/ULobNxBgRiiE6AfMWm4qglJRxW2bL2STp6gK7uVE=;
        b=yLp7SbylZpV6KkaSft03RvdgKMMDJvCbp1+9KxKl5etNCsfLKcWaKWp6vqobcyoAx4
         0s5SuVB24scHYfL5DRsd8opiUm642VHMw0wFiR20aial2/9DZWNwTSMVYAmQLCNki7jL
         Jpxocb4OXYrDxTr12FjdGB61F5AGXC4BCtCpVw4Ry0VjUOlMondYP+Dt1un41k3mW63W
         BdWiMgN6qxGRO2QvJOxAPbNEbtw23ny7uR4Gy1APWR3DeqJ7IXiENPu/sqn8YnK7tcbr
         IqosVIT6PZ8miakhIlc7rCJ6Onerf/9e2h1Ogt9I3m8D1xIQXzW7KTYN+yMabSuDgZpE
         bbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739318283; x=1739923083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LX/ULobNxBgRiiE6AfMWm4qglJRxW2bL2STp6gK7uVE=;
        b=bYCVSj0VFgJJrgN6YGlIuIZ84lUXl8voAv4OKWsIHDbU90y6qAI7sC+RB/2NdjUm7E
         9273e6DAsHhpR/HKuFbr9CqjBI6b40cZp0ZplJu3Acpmm4kUs13T6W0quMj99u0kmK8O
         g3l2IbrTx/f3TuABBvLvop+ZY0L5HAVl04pigGRUR+PiTGFupjxiL+Mdv32GHyZ9EY26
         kY34jph9kQuo3PgGjVxAnvJ5WbwNbFZGV4/ue0TtTWuZG8iZ3N3VUuf9+/SNZTR1BG6J
         LWEoTt+PoMjyq9AKQ2/5tYzXBgXuCG//dtk+v/FZK9NXuvctLi991Ghsjysydx2A0fKz
         /njA==
X-Forwarded-Encrypted: i=1; AJvYcCV48KeBrXp6dCn1wCL/ViW5oiQ14Bz5K7AzdorzFcy76TN9U67YnkmpMbQk1cLkDcfIvWQIkOliOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6205FFWGnqVoLmJUU43GH0FHXvRWhtKc+AK6HJi4zCEVeybsJ
	uY+yIiE4BP/8j0vr1ynui+DWtWgxkPR3itgqcWTGhnxJTgouSwxt77x20LjWX/0=
X-Gm-Gg: ASbGncs11r6yQKNdisa4zvwcKyulvom8UFp8PzciMA4VKWdwFlQuu0DA82N7BIU3hFW
	yl9Obpyx7Iw9Ce5YuPYLiQZ24C0bBtiwz/d/PuQIJRf/rd9sLXqDHME5ONM/CZwRAwShHS6X/ks
	zTk0cgS2i95XsAMMTCuksLtxrTnYBaBf40bXyWoXpsqZGKmPWNoKjhuX8rK69mcHjHqKfWsrNBE
	zKZDskMENlm3LwpMJ4RcOH75ABdqx6aTETyNa/k57JBrrbDKRWY3NCvMHV3WidTHLB1MoscamP2
	s2ERZb3vNcSw3Aqfp5zHJi7kNYFN6HOEgFsy7cHzcpgvR63ZARVEyiruYF+R+asFBlU+HOg=
X-Google-Smtp-Source: AGHT+IEZuHKlP0HFN8WiWm/I8ajOzqgUnqFUKxuS5iwuMpASJK2/hwz0WfYOWgwjCMYH+7xZ6hFXEQ==
X-Received: by 2002:a05:6512:124c:b0:545:353:4d46 with SMTP id 2adb3069b0e04-545181148dfmr238228e87.25.1739318282977;
        Tue, 11 Feb 2025 15:58:02 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54512236ba5sm393771e87.110.2025.02.11.15.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 15:58:01 -0800 (PST)
Date: Wed, 12 Feb 2025 01:57:59 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, quic_kamalw@quicinc.com, quic_jprakash@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/5] dt-bindings: thermal: Add MBG thermal monitor
 support
Message-ID: <sybrfmrpegq7fcqykgsfhm56wjyx5vp6zafqw2d73tiral64aw@hg4di55fzdle>
References: <20241212-mbg-v2-support-v2-0-3249a4339b6e@quicinc.com>
 <20241212-mbg-v2-support-v2-1-3249a4339b6e@quicinc.com>
 <ojukpywkhu72cimujmijzidf26654g5vkjaj477imcf4suz2o6@cmow62jcqsfz>
 <7a5db383-914c-4c1e-846e-5d68cc6a7765@quicinc.com>
 <fcd718be-fe8a-466f-bd2b-7b75d5f8dd6c@kernel.org>
 <c85903c6-6a89-4382-bfa2-2fed95f0cbc0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c85903c6-6a89-4382-bfa2-2fed95f0cbc0@kernel.org>

On Tue, Feb 11, 2025 at 12:50:12PM +0100, Krzysztof Kozlowski wrote:
> On 11/02/2025 12:46, Krzysztof Kozlowski wrote:
> > On 11/02/2025 12:15, Satya Priya Kakitapalli wrote:
> >>
> >> On 12/13/2024 2:08 PM, Krzysztof Kozlowski wrote:
> >>> On Thu, Dec 12, 2024 at 09:41:20PM +0530, Satya Priya Kakitapalli wrote:
> >>>> +
> >>>> +required:
> >>>> +  - compatible
> >>>> +  - reg
> >>>> +  - interrupts
> >>>> +  - io-channels
> >>>> +  - io-channel-names
> >>> Binding looks ok, but this wasn't tested due to unneeded dependency.
> >>> Please decouple from dependency, so automation can properly test it.
> >>
> >>
> >> The dependency is needed because this mbg peripheral is present on only 
> >> targets which have GEN3 ADC5, for which the bindings support is added in 
> >> the series [1]
> >>
> >>
> >> [1] 
> >> https://lore.kernel.org/linux-arm-msm/c4ca0a4c-e421-4cf6-b073-8e9019400f4c@quicinc.com/
> > 
> > Sure. Then this cannot be merged due to resulting test failure.
> > 
> > Please don't post new versions before this can be actually tested and
> > applied.
> 
> Heh, you responded *after two months*, to an old email so even previous
> discussion is gone from my inbox.

Are you responding to your own email?

-- 
With best wishes
Dmitry

