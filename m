Return-Path: <linux-pm+bounces-29574-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2703AE9A61
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 11:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC533B1C28
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 09:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE36215F5C;
	Thu, 26 Jun 2025 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fGBv9h7C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37E018035
	for <linux-pm@vger.kernel.org>; Thu, 26 Jun 2025 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750931236; cv=none; b=Jf+1FjDprviWSGE0dFFxdssc453cwxwgW6q51YKSpzHDu7ERuJ8EEB4kCLb2/lUv1SkefD15+/5DUaNHYc0Q5MTciYTu+dHfIOp9fzOUQVVKV/k3uK6RqFBM8+/+vgKVHiq3W20ddkWw2GdsDc6Rp4V6Kfj9AgoFG9v//AVNsOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750931236; c=relaxed/simple;
	bh=VMtWGZQmlxRjsBfICY6WknhUm1dc+SAzCwKYbEHznNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HgtpXpwBGW/6jP71yAHIWKtYqihYSO2IC6sy+gEmQBv7kjJPkNW6Liw53YmHLJPMe2sFf1QWNqcNdSByyPQ6SGCVTmFxjul15Dq9ofLAkn4l2p189JxfMP1XpFdlBNrxqJB9zO166FQqPZ/BBbI4FaMY3kFUuvSBqvIIg+KC6xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fGBv9h7C; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e740a09eae0so674143276.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Jun 2025 02:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750931234; x=1751536034; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fj2QHa6OnGmzpYNyiPz5gZAKWryswlaFrYyygxh/pJQ=;
        b=fGBv9h7CXiGSscqe+y7pRZblpGDx/6tflIHILwTB7AWm2O1yjKSEfQi+S57cClKZyF
         HnaRczzacEiEHMWegPCwu8MS4T8njsN8HkucPxOfIVGnxS1mbQ+U5TBlEG4vh0nxlfVh
         2s1ocqR/hADjmY5ihkj2wUkZ56QXO3+jbO+ZCUThHF9v3r0bBv5xVMsGLHdvat6kNJEv
         UbenpHgs7NTg1JcUOlT7ITUIyRrQFLDb9NIJNSzXBf38RGtpZTA6UCOq/E9k88JL8CSX
         YeVFyGWEInpwWJimbiiv0anm4pFc45rntyfyfe3Or+mKkbPd+hm6h0XFQMoug6s57HeF
         ct1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750931234; x=1751536034;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fj2QHa6OnGmzpYNyiPz5gZAKWryswlaFrYyygxh/pJQ=;
        b=ASoQZf5ZOG5y6HeX26ll5BrqAjfpr9+TlWgc0kYwntdSSyVxJicHtV9hiIWeXw8dCz
         78mgLatQ+Ah95pOknDYYP6jjARArf229XZqt3H3kT+7ot7T7lI54kxwq87a7btfYd4c6
         vXwq/rJjDU5IC/9/IeLSUKLKq3GFreohxRQBMY3oBZzkKjDgihK+D+68KhNXaXW6flcw
         JFmxqIR58C9W8w3fCltIdR90jxcLB8ArkaXN6ngDoWujWo3s6dMFI2A2v09jdwFiSujZ
         2Zrm6F1R48k2PzTbQ3JG1KyjG5FVIUaimpmXAfstapA8bS4T9Y+V4suI/7z6rkLCnlcg
         jgbw==
X-Gm-Message-State: AOJu0Yxtk5ukUaYmueTyU746W5CvGXMcX3udP+USsU+3h56PP2qyMbRB
	q7CH+wCVyBN3gC4YTxzmMyACletqdbktmqp9jGkBrxnawJhBxwciZg7oRt2eu332HKCYBgrF9Tb
	sDXFtrITAuLHz5yhfbUfcvjULsaZsyUfKRrUaEGczeA==
X-Gm-Gg: ASbGncuzoTZv3xhBiNruDFstEPUH1uvTfvOYEEpDU7AMZqudRs1GhPJLfHn/oIXSBRG
	OELDimtsVOBkZKtLclCSWS3ritmvWAYEVt/r+Migi71Dw1Q1UHdkIsRf8NtFAeN4mjlteWhYa+z
	kb8VB1q6R2mn7aBRsEI6vnE0RK0KHgzhjsFOIDg2ONplcx
X-Google-Smtp-Source: AGHT+IEHwERgRwCBzB6vbsL1sIE76j7GbjeXErZ4zJp9hup79xC50wEIXLcWf5xeAXwh2fM3WvRP1rlkAgqjvq3ixUI=
X-Received: by 2002:a05:6902:2b91:b0:e84:2cec:1c9d with SMTP id
 3f1490d57ef6-e860177f71bmr7997438276.41.1750931233869; Thu, 26 Jun 2025
 02:47:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5011988.GXAFRqVoOG@rjwysocki.net>
In-Reply-To: <5011988.GXAFRqVoOG@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 26 Jun 2025 11:46:37 +0200
X-Gm-Features: Ac12FXyIi7-z5quv_0KDUCEzalPBWfhqotEQ2Vp_aGtEe5qy39ECa_ySIUN3UIo
Message-ID: <CAPDyKFpBTz0M8DmWHLLm7x4c8G5PpQNv0Zj7mrZ9BewTBi1skg@mail.gmail.com>
Subject: Re: [RFT][PATCH v4 0/2] PM: sleep: Handle async suppliers like
 parents and async consumers like children
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, Chris Bainbridge <chris.bainbridge@gmail.com>, 
	Saravana Kannan <saravanak@google.com>, Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Jun 2025 at 14:55, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi Everyone,
>
> These two patches complement the recently made PM core changes related to
> the async suspend and resume of devices.  They should apply on top of
> 6.16-rc3.
>
> They were sent along with the other changes mentioned above:
>
> https://lore.kernel.org/linux-pm/2229735.Mh6RI2rZIc@rjwysocki.net/
> https://lore.kernel.org/linux-pm/2651185.Lt9SDvczpP@rjwysocki.net/
>
> (and this is v4 because they have been rebased in the meantime), but they don't
> make any difference on my test-bed x86 systems, so I'd appreciate a confirmation
> that they are actually needed on ARM (or another architecture using DT).
>
> Thanks!

Hi Rafael,

I haven't yet got the time to test these, but the code looks good to
me, so feel free to add for the series:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

