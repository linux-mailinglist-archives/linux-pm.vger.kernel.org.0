Return-Path: <linux-pm+bounces-5350-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBB388AE62
	for <lists+linux-pm@lfdr.de>; Mon, 25 Mar 2024 19:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7282A636E
	for <lists+linux-pm@lfdr.de>; Mon, 25 Mar 2024 18:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00CB3DAC14;
	Mon, 25 Mar 2024 18:14:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1613A3DABF8
	for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2024 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390445; cv=none; b=Isoa51blMxywCLyyKlSJ6YBdjLhHRjQvhd6BRkQgItLdLkzte/pbV1O70jD4mcNi7aofUJ9yFv2gEs74dX7qV8K0v1QkaGSRbEsaY1ufqphhnarKW2bzmR7JYEDsPgO6iyGvaZOKPWTD6TgRneipueewA2kxvDw31XAHAvv3K00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390445; c=relaxed/simple;
	bh=SeziXVZwEtJKE6/usgs1evI9KCh0D9TraO9R7haZ8bI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hu8fvclw8vGDSvYIDKLYWtDMLIJkgnzExmUFyUUu6SEQzEwho87qX+5ZwHRJYrgMXzFwlpGsy2tib0jNpdwYGbnfthYhDINgbYt/zHgKT/SKgfJ/maGtWhULgoW8Aa+3Ubkz/b9/CHnuhAiVo5tvgBvsmKaYv3mQd3ZLTP3dDl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5a4930d9c48so511863eaf.1
        for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2024 11:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711390443; x=1711995243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5h6m+YKO0gdHyAarpunJwPyjjf5K1fro8w+niLORDR8=;
        b=OHQmolylR8b4oIMZgq+fHN0snOjNGqgAy8jRkqKHOJXaL3FzqSBCbDkx6+k3YWy2p5
         VwqB5cdF6SyHzoQ2hrxjSH84lO5WiPJfdCApdGtVBEvb785UQ73JZgE14gkndS4+suLX
         KSC+e6TFQ7gYRU0LrVayQWPpTOedEhRSR4YLQwfRbouxguPY1C35TD1ET5GJ1HLSXO+L
         kmMov5t1tPXu9iO452fu0P5GrP5DUf9i+dP9bFzoOR8yI3lMKWDHlP6A0JzJm0u8emGe
         zVnfpiNma/X6VDyBSa+kVdNFrdeJChDNEYI5jcOmPc1qSM7DUOnGBFZTNkuzf9RGzOYS
         P1Pw==
X-Gm-Message-State: AOJu0YyYeZE6E2aV00AIZqCozpQ73yecvigw0cmCxd3SJ8grOxIi8AGa
	mhm7ZULU9p+EyBQOUPiWS3pY7ZgKVcvrLqp8jbRr6IVWqQ++jqLq1JC32tB3DpJ5JQ8gtQsMrUR
	7fi/IaGx/+R73k1DRXccz9DD0T4MtJTHpAAQ=
X-Google-Smtp-Source: AGHT+IE+BdfKJ9VeShQ6y85U97jzkhL+aahbL6GiYEc/PZGA0hjHbGgKwMNrAGAkTeG6jQtwel4GBHZ0iCW8umYBWog=
X-Received: by 2002:a05:6820:806:b0:5a4:6ac7:de6d with SMTP id
 bg6-20020a056820080600b005a46ac7de6dmr8637289oob.1.1711390442843; Mon, 25 Mar
 2024 11:14:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1974187.PYKUYFuaPT@kreacher>
In-Reply-To: <1974187.PYKUYFuaPT@kreacher>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Mar 2024 19:13:51 +0100
Message-ID: <CAJZ5v0irq8zNQZvQiUGNnFdBSLg_sWyBTHB1x-KjdkOph-h_yQ@mail.gmail.com>
Subject: Re: [CfP] Power Management and Thermal Control MC (LPC 2024)
To: Linux PM <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 5:00=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> Hi Everyone,
>
> My original attempt to send this CfP to linux-pm apparently has been
> blocked as "suspected spam", which was not very helpful, so below is a
> summary of it.  Everyone who has been on the CC list of the original
> message has received (I think), so I'm just sending this to the list.
>
> I'm looking for topics to be discussed in the Power Management and
> Thermal Control micro-conference at the LPC 2024, so if you have any,
> please let me know (the conference is taking place in Vienna, Austria
> in September).
>
> Please note that LPC topics need to be about work in progress or
> future developments, work that has been completed already is not
> suitable.

In the hope that this is going to work, here's some additional information.

The conference will be held in the Austria Center, Vienna, Austria,
between September 18 and September 20 inclusive).  All of the relevant
information is available from the conference web site,
https://linuxplumbersconf.org/

As far as the topics go, everything related to PM or thermal in Linux
control that is not some already completed work should be suitable.
but note that this is a preliminary CfP before submitting the
proposal, so this time you don't need to be very precise or thorough.
If the proposal is accepted, there will be an additional CfP for the
actual submissions.

The deadline for micro-conference submissions seems to be April 4, so
please give your suggestions before Wednesday next week (April 3).

Thanks!

