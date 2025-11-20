Return-Path: <linux-pm+bounces-38295-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F78C73951
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 11:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 705EC2F829
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 10:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AE731A067;
	Thu, 20 Nov 2025 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nDTVVDlS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A2921ABC1
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763636146; cv=none; b=UjlnRy+v+FV+l6gcs++i7hQEbwagcFP9wJ7PSLrhsNapvlO6l8ihBV3fVfTI8EoNPyAioYWv++YeVlv06USfnz9ZEiyadw23J8MvT2ouIEgZMgMcWfR+AgHK6HAulbwWUpjpPhrsmZ5MnVYe1V/4KGOOHo8t766HkeBAI4fO4bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763636146; c=relaxed/simple;
	bh=cvbHrmgf08XIYn3vUZdntoO4zAMQE+fQWmkHA4zq24U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+b5cZrT5K+9o+D0ovGdGM0ed8xf8TIlgltiu9eGxqrAM+1fLGhY1MLpcwxtA9lvQAY7fmVqCkXmHpVxPa6y5s70GUonvrksUaVP+3l0K0kSy8Br0qewHzY726HL+kaM9yfX/H5os+ZV/F9F5abkh0ozM/mDc4JRPjRilKePdN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nDTVVDlS; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b713c7096f9so126745166b.3
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 02:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763636142; x=1764240942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sEvhisOEOg0eUGED/5mmqd5Rh7K5bewJZQlOmHEK/fk=;
        b=nDTVVDlSwyINAUYdz+nL+UspcRrPimaw6grB0wXSi9DKrNw13nboKdfmGbtVFgez/j
         L8NE6F9tfRxicsqLoxA5wyMKOjVz8gRS5tOLXKcRqfI4UsT/WXDpVBeM4aCOzZSMY09R
         zE3Y+F6Xt8MR4191119DN2Mobc0Q46EO2wIkuKzDFUtaP2/NqdGFYr0UE5ANB+IfCErs
         nTPlcM3J0XoPEP1SjSoMOr2xN/Fd92QicfkktG82CbB+3Tpjed8/ebpL2P9jD5qum3lu
         NzRV+g7cVTfgDy0GCqE902VDgQOfXL/vN6ovEIJUfhSIYZAQgrxndjDj0QCpRQRPgWYh
         0Kyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763636142; x=1764240942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEvhisOEOg0eUGED/5mmqd5Rh7K5bewJZQlOmHEK/fk=;
        b=ndc/UQl3gWItYuk/4FmmBxCpAxMqt+BtqpKLAwEv/x4h+1wVZkJtnv/vqvOs5brJLu
         IwS/fcf8nmwIVpxEayGuGIiAahd+RkpYBb8bbrb2+t5fF8NjLxR+eORAbPYK9K+uWgfG
         gEHqwYtIF7PDeeuz0QN1et2pKALYwH8x88PVbOLgl/Yqg0+LfGTBBiLZD9HFU40ax5Hr
         +UIdOQtoyhzlF+77kOT252hACVkxaJ36WeVovT9jrcF1XExNVqWn3P6PkpqDpdPj16Uq
         j3zOrCcZMUT4F0myBjKNN/zTEswDkCgpVcCGxw/mWemjAMwNbJqG67uUcKNEfrPRFLzQ
         5r+w==
X-Forwarded-Encrypted: i=1; AJvYcCVgw5jpFrAOrVeDLArQdgFBttPeG3lxgyF/+12J3ZWLtuVJUeiH6/Z/9yilvBKk3CchAqMomvyoFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTL1YUv4xYGRVJ3R2UDZA0irYPamALEUCSi0DZr81QI9wtxCn8
	ylyyrOk2F4SX3HEEsjIHXI4TXQxL0bejry/4PIKwIJccVZ/Vojxwemv3oXep/j5FuOxLVYoFsXp
	ZCYq63hGaxCRLO2X8p/LbkxyUNxgabDl4FnbCCB4xPQ==
X-Gm-Gg: ASbGncuTQmaVMUqvWX0ZccBjy5I0upQV0n0sCJmzF04OeiUubWSMEXwB63n8iyXSWCB
	aDno/6DWQSiYEjP6JCJhyBSOaJbnA07uyIihM7IiyZmt4u7dHhOy8N6/ufEAduQYtyPnojFmTrN
	hWLhzo5T35j+xDQc9k0WQDZ9QRLnaYNF6I048tByugRqt08RzujRLTZkCamqXuE8Q3l774GxHDv
	DqsXPV7cXRv+5tBtL+RwIO+ahCGnXT6GtyemsNGjS5DPYzU+nwZuuZhm1KriGgof0fYeuznLcQY
	Tazolgc1wSmkbaJXdnrXELc=
X-Google-Smtp-Source: AGHT+IEEbNQPl4pHbHNC71Fe8G1/2uwl/krtAuMVOHWxz3fLv34NYSeDkLKF82fimJciS4w0Rmz8whpk90sogY49m7w=
X-Received: by 2002:a17:907:9403:b0:b76:5393:758d with SMTP id
 a640c23a62f3a-b7654eaf6a7mr35795766b.34.1763636142531; Thu, 20 Nov 2025
 02:55:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <q2dp7jlblofwkmkufjdysgu2ggv6g4cvhkah3trr5wamxymngm@p2mn4r7vyo77>
In-Reply-To: <q2dp7jlblofwkmkufjdysgu2ggv6g4cvhkah3trr5wamxymngm@p2mn4r7vyo77>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 20 Nov 2025 11:55:30 +0100
X-Gm-Features: AWmQ_blAIbaFsVzIrvLzF0Uj_TD5xSQkMIO9nrj7gb4Q7GJzX0PkQO_vz47YO58
Message-ID: <CAKfTPtAkYfCYc3giCzbDFLBDNTM-nXjkE8FXMZhvJj_im+Qz0Q@mail.gmail.com>
Subject: Re: stable 6.6: commit "sched/cpufreq: Rework schedutil governor
 performance estimation' causes a regression
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yu-Che Cheng <giver@google.com>, 
	Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Nov 2025 at 05:45, Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Hi,
>
> We are observing a performance regression on one of our arm64 boards.
> We tracked it down to the linux-6.6.y commit ada8d7fa0ad4 ("sched/cpufreq:
> Rework schedutil governor performance estimation").

Do you have the fix ?
https://lore.kernel.org/all/170539970061.398.16662091173685476681.tip-bot2@tip-bot2/

And do you have more details to share?

>
> UI speedometer benchmark:
> w/commit:       395  +/-38
> w/o commit:     439  +/-14

