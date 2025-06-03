Return-Path: <linux-pm+bounces-28014-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5BCACC692
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 14:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9471720B3
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 12:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDAD22F177;
	Tue,  3 Jun 2025 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlONGIMP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8473622D9F3;
	Tue,  3 Jun 2025 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953626; cv=none; b=TqChbqt+5lLH0WfaYkWHDSsn8EDe2QcnGZ4Hyfe+4ZTJ/Zb5LflWCT3MaNCnU9p+ct7I0aoau6xcDphV1IvuRiVMdDHljIbmCFljzg6fa9hacBscPv9bC6e70kSjKDbSjIX2fd1v5r08mZdnZjFE4A7gzLH6oDdNAeTqs6LWjUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953626; c=relaxed/simple;
	bh=KS9rkPTGJqa2rNA3qxQ2zxOhS+BwbC1h7+9syRUgbFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvqgi5KN/vrYCygUY5FwJjh6h28IpGvSMi6IBqDwN/mAeAlP1ueXSMqzNwSTQ+rV4rpTmIko1oYgZ9SbJ7vkTCMq4dt9Awk9av7HgiLIcselC/F+yncEJ9om0kqUUKiKo+IAARh8AK2XaFDySTaJBvsuoT3djioHg3O6/3nM+Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlONGIMP; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-708d90aa8f9so50036897b3.3;
        Tue, 03 Jun 2025 05:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748953623; x=1749558423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KS9rkPTGJqa2rNA3qxQ2zxOhS+BwbC1h7+9syRUgbFA=;
        b=VlONGIMPI52acyh2t8Oj2kD+NaPLb+Sh5wdnRmbZjWnxaAvWjt22rhm+42u045VhGY
         yg8Qv6odkMfD4S0XRGYin7TnurAx4e8PDy5iqG/7pQELMKT0gW0YtV9/469Zj1GukrUS
         BHjJr6iG1Va1YaWt4bvLWGh7Tjel1YhFDyePyPgq2Y/S8iUU8fK5WYFVxSIJuB4NYSHI
         DOOj3ZFUy0dGRlJbxt27J3P8cOjckQVcLkiOSp4JZjKQgpzvffS6Wo0lr1lhooGTbjIN
         VoXpUWtt5T0/H7kcYD+f0lStU3KwijFJclzHrBrrpRxoFuWexahO6Gm4Y622oitrZrTv
         qUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748953623; x=1749558423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KS9rkPTGJqa2rNA3qxQ2zxOhS+BwbC1h7+9syRUgbFA=;
        b=KXO/K/BGonvauoqsvDHrbN88jwm2PhA7wvUsQkcTSVHlFNEqsEY/h4qKX6kUmN4HkY
         znq4k0ob2TrMYjB7OwLXBBSHpVBmGZ/G80z/k6LjYmntExf5jGwviKhEOO6x+hyWEajq
         s0GBe7MHcoto7RIQbPzvDbXkvGcYCnNaA+ZFc13DENsFgntvdLgSrghk5gaoZHW1m99e
         G12CXBPBrSuLwojjuj8emYvJ9c1y/Afd+7cd3LromU2ZhueJGZEyOs+8WS5BA0rTATpe
         vFIhbJbA9YPeLiwVx0sjTbsxuswbFTvgXSEPf5H2ObjzBhJkCZyTO+nqJnWRYsCeGJTR
         O6Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUXh31yJkbVK1XIcrEj8503Re2buop0mJjY7rtIO0J3s9EjwnjEo5ZCshjXK89mdIQKf5sWN3AXRVE=@vger.kernel.org, AJvYcCVsr1Z8556N+ZFILBqjXn06FGEOS6eWkaL/wI+D3Y4fxnDnKT95Z2yNwCxsw6EFeoBmHf6dAqSiyRwp2xM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHLJonGYOQ23K4u0a/+EEi1MPp8Hdwgo7DsDwfTKptNYNNrOq4
	ugRVhFAbrXKV69qsgRmNeUX0RIeTHXKfArGGQ+ZujvrA1KY90Tv4LnntmhjcdFdaCV573ozDuQ/
	PZyJOZg4muOs4B7PqQZXy0a2Hk8HAvxk=
X-Gm-Gg: ASbGnctEEYSv8HXZZeau3/7wuF72AyAT95l1/I4rl1nQm51TcoTb6r+QkX+JrKxw00z
	j/N098w2W/p98z/DBuUh9MZSGeqvYJF84m3GLpGlTNWqfOAR+86TqmOBD+Xg66PNtb90sqk+tGh
	S0zWtNxOLRXbqvyvEpA1z4ptsLJ3Bd80HNL/I+yJ8V0E/y4OrgJ22th+RmOVuXyKZi8A==
X-Google-Smtp-Source: AGHT+IEbfkw52dYwb3QTIYKq+WBEWXWfcgfIwhgKwctTOG2OKjmN/e1jk1HhPX0yI+JSVRibG8FbMs6A5Hv3I1EPdFI=
X-Received: by 2002:a05:690c:7488:b0:70e:5eda:4810 with SMTP id
 00721157ae682-70f97e784dcmr265465657b3.13.1748953623445; Tue, 03 Jun 2025
 05:27:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aD2U3VIhf8vDkl09@debian.local> <CAJZ5v0h-nrVamqiAJ957aYjHqaeAZUUW7BRi0WxPgCFc40M5cQ@mail.gmail.com>
 <7f0e2865-d35e-4a13-8617-8679afb4b23f@kernel.org> <CAJZ5v0gL3rW8dOxXdPWYjZuq5kAaD8qTa4vZ5++k9+0WniNAdQ@mail.gmail.com>
 <CAJZ5v0jDZQaR8S6Kn_RoXHBU86+tpjp=qgyxm5h03YEe2S=nPg@mail.gmail.com>
 <aD7L0RD4HT-mEtBc@debian.local> <CAJZ5v0h65Gt1Fw35vp2k8kKu62+goCD8WF8u-tvhfWW6a7xHxQ@mail.gmail.com>
 <CAJZ5v0ggPHhYcdNos2o8savvq+-zpPTaQunjOkR36k3VwF3_CA@mail.gmail.com>
 <CAJZ5v0gF=ewooE0cUrNfe5_inhnzq6bqw8VTjkFwr56_wrptJQ@mail.gmail.com>
 <CAJZ5v0hpJSVdiCN29=kbV8KfgU1y1d3hFfshtBoMpVFXf+LvBQ@mail.gmail.com>
 <aD7nOMP3xA9BR781@debian.local> <CAJZ5v0gAcohRWuSZbFWvyfAU9Vjc7nRyj+AFRYQ7hcGEXdPxyQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gAcohRWuSZbFWvyfAU9Vjc7nRyj+AFRYQ7hcGEXdPxyQ@mail.gmail.com>
From: Chris Bainbridge <chris.bainbridge@gmail.com>
Date: Tue, 3 Jun 2025 13:26:52 +0100
X-Gm-Features: AX0GCFuyhCVtL8Hjsbmm71G8qbnwHENp7Q1i1Zyf7FagPmfvh1ldlhfNBWSaUl8
Message-ID: <CAP-bSRbVjcXBvxDT6ZQuoRB+JF6A4LhdMVnNqnaQC0bg-xg2BQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] PM: sleep: Suspend async parents after suspending children
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <superm1@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jon Hunter <jonathanh@nvidia.com>, Saravana Kannan <saravanak@google.com>, 
	amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Jun 2025 at 13:24, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > This patch does fix the list corruption, but the "Unbalanced
> > pm_runtime_enable" still occurs:
>
> Have you applied it together with the previous patch?

Yes

