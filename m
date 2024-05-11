Return-Path: <linux-pm+bounces-7737-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C558C2F85
	for <lists+linux-pm@lfdr.de>; Sat, 11 May 2024 06:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 957361C20F34
	for <lists+linux-pm@lfdr.de>; Sat, 11 May 2024 04:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CCD1F932;
	Sat, 11 May 2024 04:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z1a/pyhb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB9117571
	for <linux-pm@vger.kernel.org>; Sat, 11 May 2024 04:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715402028; cv=none; b=FIUG5D9zOOZy+bGR+Uqp3IMjq9k19r4PZbR5gnbvuSI1dtjPUAmq2JI3EAluV0BrWk9WfPYdtokqXMoMcVdkuAXaAlNs6WGpa7ZxThbbeDSbfSchFbXdj3yJBzORyrSDvnxjgsFMzU9i7U5EI5SKTFKrEaYTQJTarO5H2Oa6NJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715402028; c=relaxed/simple;
	bh=iR0XyjTDqqc4Wjjno2PBiK6F4GzoKq4vOnOceQyaYl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZaTHWeEbQosLvyeLzYIu1yoE+J8zzWT/ocgT/lNdrO2p9yjWlzyscBSvmiqFC97v7zyQFy1udv0oYDuhLosM6aKN9QU4mPduWHjf8GNpwnuKVElta8qY58N+7tQuSt5iSCjmXdAmIRukgPTTfqiXk2e7aDTwcen6LvPviGBe1LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z1a/pyhb; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59cdf7cd78so676796066b.0
        for <linux-pm@vger.kernel.org>; Fri, 10 May 2024 21:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715402025; x=1716006825; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iR0XyjTDqqc4Wjjno2PBiK6F4GzoKq4vOnOceQyaYl8=;
        b=z1a/pyhbKByCLHpA2wu6VNPnaa+Qi13AdMPwcS6pTEzWhvroq4Y6uU1xvEwXo0qrFc
         F1O87gPYoHEeV3bLlgeTSMeaJ3LyZm49JJjHI7ZrJY/7YlLPVJkzrlWfwN3YkMk83GPw
         IyXDj69JD6Jud5UPDUVK5D0uA1hErCyWePP0W2kq4NJprvjFnn3N/V7sNXIN3ubd0on6
         nNnXJL8mOd9ooS6ATQienkQqRYAojYhCknuKhTfX//SPm9cX2lhN2LRSUICKbI7OO3Ap
         I0lWxGfRR1yw7tBzwWi4hLPt7ezNufm9iSbI1cS9gD/8A7uGPhttAUjyhxWppallzCHw
         FHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715402025; x=1716006825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iR0XyjTDqqc4Wjjno2PBiK6F4GzoKq4vOnOceQyaYl8=;
        b=YmEgILPJg1fC+8wWtxgHJJhyCZyNuZZgxktgEMVVHXs8dmk11fN5HxnyPeH5ez0uLH
         aWIF7IcT2iO17TQBSrjzXXp0Wznz9AhwKAYeHND5/MUv1jgrtKfNh8JHuGW2OOZrqd59
         0EBhroURDamyqHRkJ6+afLm3SFXObO6TEKfs2GQuggDEoRazKIzINowpkVamhP58TkT3
         eo2xZqh3lNFxazzytoE2i6bejlyo/SemXgoYLjR/aWrA7crUT3DdriqiEKlMQLeF6ueg
         7S2tgxykch6+7Qk4sGSpwNBctMEwrU1dNggOgDc8/UYGZbKmm1CS4poCtMw/nLa3szKH
         OOcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfZm9W/ovGya3sZJmx71ltLBoplJm6a0+uwDPyMfxi6NcuWRcE+VJVbkY9/je1ReWZrX02QQQQgq4fk05975ggO9dEiuY0jmM=
X-Gm-Message-State: AOJu0Yx7B5miPArBUUyDFlS7IEHe6IX/F+LQPn8FXtwtSPIMH/utcBVT
	cR1h6kcEnDO2oilHApaBENtXskQNwIq7Fn/vgVZIbVBFxpPqrZthSnv9lJqwt2LFEhVhghH2GmK
	isHGTwnoiodTcaLJU8EKwW6BMyfnk4/gsgHM9/A==
X-Google-Smtp-Source: AGHT+IEcfSlcjly2piGh73gfy+/TpqxiTmB3jyv23ofh2Ef+M8gbCZem3TQII8uGWq0wSZKXW4p616cTMjJVi9MfduM=
X-Received: by 2002:a17:906:dac3:b0:a59:b6a8:4d74 with SMTP id
 a640c23a62f3a-a5a2d3bebeemr350201066b.0.1715402024326; Fri, 10 May 2024
 21:33:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2eb72832e852c80e5c11cd69e7d2f14cefd8b1cb.1712903998.git.viresh.kumar@linaro.org>
 <e6fc06eb-fe52-4cb3-b412-a602369ee875@leemhuis.info> <CAPDyKFoHoKK-RZsGwnZhbW9_ZRQtL1MFZBuVVLMx-MxL2cQQbw@mail.gmail.com>
 <7c6df194-fce1-401a-98c5-c903d78627c4@leemhuis.info> <CAPDyKFqKRy6zJdBpK3bNTvkvAjty691-Vi_HV3E5CeqgRAWGmA@mail.gmail.com>
In-Reply-To: <CAPDyKFqKRy6zJdBpK3bNTvkvAjty691-Vi_HV3E5CeqgRAWGmA@mail.gmail.com>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Sat, 11 May 2024 10:03:33 +0530
Message-ID: <CAKohpomKbhdXRgFxxbg-_hG5EFZT0LrvfQcrwjQPon6AZNbGag@mail.gmail.com>
Subject: Re: [PATCH V2] OPP: Fix required_opp_tables for multiple genpds using
 same table
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, 
	Vladimir Lypak <vladimir.lypak@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 May 2024 at 16:14, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> I wasn't sure of the level of urgency in this case, as I don't think
> we have that many DTSes upstream that could hit this case.
>
> But nevermind, it should be easy to revert/replace the change when we
> have something better to take over. Viresh, feel pick this up - or let
> me know if you prefer me to pick it.

Please apply, while I enjoy my holidays :)

