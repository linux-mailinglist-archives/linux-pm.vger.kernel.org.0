Return-Path: <linux-pm+bounces-3063-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE29843F92
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jan 2024 13:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265FF1F28C91
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jan 2024 12:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C44979DB6;
	Wed, 31 Jan 2024 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VCNI9Is3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8602779DC4
	for <linux-pm@vger.kernel.org>; Wed, 31 Jan 2024 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705006; cv=none; b=K3xJ+ASKgZ8BxLB/82+v7B9oOO263l4m6mxolK+z3QiXjDFgfkYilSHSSJeFKxyoK705T/CtTvLk1+M5SaW2nClUxvDR4eDqloHEHJxFijYKrxHVa+QbYAVE5qg/ghStlZZq5vs/UNVg+Hf0lA/eOnKtGSmb66BYbwYdXXsx0Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705006; c=relaxed/simple;
	bh=ahkd6NRQjX+1YbZ04uWO3jNts1thzHyPVgN0sDH7EQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SbgNXqfJPjBQwoSOhCQ6aGuwkrwiQ21841XE/ouxElX1jEGRgsb+yC+OqWh3CQNWdtzoXRvRg011k69ET3uDTaYar+Yam2oEscEV2xvON/oKOHISafLJyUqr3PjNZeoWroihlgZLN7Dj8/tkPuuUnwTHcCdhaqF4Jx+fkPpQzxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VCNI9Is3; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-602d222c078so52523227b3.0
        for <linux-pm@vger.kernel.org>; Wed, 31 Jan 2024 04:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706705003; x=1707309803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ahkd6NRQjX+1YbZ04uWO3jNts1thzHyPVgN0sDH7EQ0=;
        b=VCNI9Is39drr3En/6Hp+1qKt6+089FUElfMStUCeLiErGiUIho2dgxzUHgdnwKYwZp
         MkQFjDymPEglnvqm+8VEwJe7LmvCyl+evgLW1QNj/zt+ewfEykyQAtaY+XcsdD2tZwSG
         qKsvGpTFa5zFTTvvWj0oiTgsnXQ9e4Su89v1p5FH+DZlHvQzA0PjL0scqkpoE38faC4c
         9N8SWmN9oj3DtHaJNcEhudo4976W/4QdfszDNSFrmeDf/1/rSkfyR9RWMKUD3Tcev9aZ
         mTq6uNcE2NacLEgVYBNBUEniCwrFpR1NGGQ2VH6RNvqo4rZxuSjxlDaXbTlhcdCJGvgw
         IlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706705003; x=1707309803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahkd6NRQjX+1YbZ04uWO3jNts1thzHyPVgN0sDH7EQ0=;
        b=uNC0VOc1K3hbLaWEwPhMuMj9H889UwP7IaNRKH1PcmpSxXjoKQieMdPKG3kQK5wM2e
         cFG8dQqzlJBTXt4f1ZoSw8DQpc50ECXtJ2om7O5PNGlaEx5XZIv/qdVAJ9KHcJd9FSRa
         +0CgcQwfRcWb+byIcOv/gd/BvXwN2b862jcnAoOXqsPe9IEatE+nXZReVBjh9DnKQHDB
         rtTpRGv7wUaHpgYc5TpFx7Rh/vRAijFmBGvkQbQMEtRgfs0fRrro2+/eHpcgxB+8mdPE
         U0w3oE9a/YaV0litWJlrJzaX6bOq5xPrDDxfVh/i61BInPckTA9u2PNg5DfTvQE5NE+J
         sSIA==
X-Gm-Message-State: AOJu0YxZ0VEBAwQpYCn6MLe9NOKH/6aW17g3EcHq+aJbxQkP/5sELJRP
	Bqpr1/26/ohiCyU2Ru37nlvodycsEp/gguT2C/pjxwV8UAIWzB+Wm7Q9RazXkDke9XGwdT8WH1o
	Y/icZCCtH19Z9lGOdPpaUGTf6vJqrfrmKaQyyvNVgVCPsFoFgfOk=
X-Google-Smtp-Source: AGHT+IGK45pFu9Pa1Y4+JOrlMYezN48nzfJwuAw7xA7NIk7/mMcASK1C1sKK2CK7I2+RbRleWeQNhGbNoUIiBg6vArs=
X-Received: by 2002:a81:8404:0:b0:602:b474:bd64 with SMTP id
 u4-20020a818404000000b00602b474bd64mr1319638ywf.13.1706705003378; Wed, 31 Jan
 2024 04:43:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5770175.DvuYhMxLoT@kreacher>
In-Reply-To: <5770175.DvuYhMxLoT@kreacher>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 31 Jan 2024 13:42:46 +0100
Message-ID: <CAPDyKFqpS0jwuxUe=NLA_Lvf2zdo+98ne3iar9Uqu6P=DFNFDg@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] PM: sleep: Fix up suspend stats handling and
 clean up core suspend code
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 17:32, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi Everyone,
>
> This is a v2 of
>
> https://lore.kernel.org/linux-pm/5760158.DvuYhMxLoT@kreacher
>
> except for the first two patches that have been queued up for 6.9
> already.
>
> The original series description still applies:
>
> > This series of patches modifies the core system-wide suspend resume of
> > devices to get it more internally consistent (between the suspend and
> > resume parts) and fixes up the handling of suspend statistics in it.
> >
> > The functional changes made by it are expected to be limited to the
> > statistics handling part.
>
> and the differences from the v1 are minor.
>
> Please refer to individual patch changelogs for details.
>
> Thanks!

I have looked through the series and it looks very nice to me!

Feel free to add:
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

