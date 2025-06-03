Return-Path: <linux-pm+bounces-28023-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F9CACC7FA
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 15:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335583A45F4
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 13:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BA0230BE3;
	Tue,  3 Jun 2025 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrwXo6N6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE51231826;
	Tue,  3 Jun 2025 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748957816; cv=none; b=ZvoHiW9PAMvUXQuzbBTpdFg2YrRJBB49Z03Iz6hd6qdVL9qV9lqwi0Nx4To3ZI3ua/bM+bMCq03yM7NgW0iIXNX0Jm+LA50FTskPj+O+N/U9y9uzT0nfW4Oa8dKCSPCpgBqSsK7knJzhlCmEckyGeb9S5sbXtHXITECWqpVQPTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748957816; c=relaxed/simple;
	bh=le5QR41xeH5K5QxGsVQri/RDT/2BLTURcIV+cKyLXfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeYyJVriG7ljD1DlnnfTHVfCll6Rf7Aqs7dOhc3w0mbpvORBFzeOxak7D2NPc5F5+aoTVikH8AD0n2Iz8yRBp7ymE83YtBUgzszk6oyxnpw65UktYV5b9oE8lPGIr9uD6AHC1xPOTO19FcVTgq/oNkBpulTbcm2hgYo5mslgArk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrwXo6N6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so65365625e9.2;
        Tue, 03 Jun 2025 06:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748957813; x=1749562613; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XwaOA2UFIdL6uhmEEF3zq5uKFSYlQf1QNo+y/xH05aY=;
        b=VrwXo6N6GUzTFMR8BX0VInjiMpGuyzAj6kv98URXp8LjZi3vZ+OSJ1XsiFCkNqXxMM
         q0ic76K1o3+QMasx0MkEHwWtEMVfSAsbPpt4G3Y2DfOim9VOj0oVcrBM5N8dVNAir4us
         3t5t445VP333qrC46zMudLH5VqHJJUGhrN7gLgohJp2RAfyyIHVYVYvdPJGcExNuLM/Y
         rS7ikHuMkh4wHyraUnKlVG/uMB0x0mSJGvPU3xoson8m9KPdYQ0YL7EZmyaBC+c8FBCk
         5by/MJg7jP/6LEfFLxX37sJZusQbtt8QL9qaMK9pm0vBYrskTjMjXa2W74bxEw7lTpBz
         xtzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748957813; x=1749562613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XwaOA2UFIdL6uhmEEF3zq5uKFSYlQf1QNo+y/xH05aY=;
        b=ZmE9C6tor85KNQwCo4s3ELO1Uc356q40BkPlgxh7irTGqZ73f1mIrusRvrm9sbEyyM
         sJ8tU5th43k1ZG5nbtHXtzOARdh9YU2q4r1wqm4rLxF22ZmXmJ4qCS9fEnPSTwqH6zg8
         Oxvnt4AQ/cEZpFDuaAz2yHckxDxcwwgAZPYkqtxbOKyQYVCqbY1gFFCqwuXQ5FzXol4K
         aIUXNwZle/WzxNUzI3rta6WozS2i/GANTMNy9Q8E6UP7Wu7gojpRRwVYfXg5wT6ONupC
         UicGu8xMq/QUBUYzN44GT9Qk+Ldu9WHa+rHkLcwNL23y6MO1ieWCAZ3Okm40Lg5Xd+gS
         D26A==
X-Forwarded-Encrypted: i=1; AJvYcCWJKZ4Tq2uRUjbReyrd4FniYg7LoFdcjZ1Cs10eX7IykFwsHFgND+sDwZoFGX7tik38a10q5OYQY8g=@vger.kernel.org, AJvYcCWyz7nebBLlRQZ8D41507tY21wHomCFVFc4A5XGDHV2JvPP7H3CVRIuBQx+FTaRU+bb9MrCubRDhkxg+A0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbr6KpyLSTrlW+qhYKUOqlNvon074Es8AjXCZJH/JVtZ5PrGEb
	7iJftdaWCxEsqCNB17E38Njt8Vukbxze7c/cd1BNVWdzB8WCU/EaajfK
X-Gm-Gg: ASbGncvUeRrKepyuXl2Ia7xNMSsFCk0rDk2twP+Ci4n1ZBp7P3dn5Giv/93sIsfeHJI
	fRFObntnWanamxY+10KN4L63uBpFlou/kEo0bpaLzcYaHrXT/EA9EFjkBXjK2OKx5mC7fTbJIan
	SksAmP+HnU8woyw4Y9Xvq+hIDXXxIWprpBMv7ttq+y6j6zSHHhX68VybafbX4gNnZkhojL12mOM
	1gxdZjBSHXSG35YwKF0FxaMOWq9wj/Jk04hLrUGB866TW1sO6mdKJQZTfv2L8ndqWWPypNztBfF
	CzIyUdNubouToJVANQuDQlOXndng9dHPxwM05UV1YNEAfqblYF5UtRR6QZ59
X-Google-Smtp-Source: AGHT+IHlffBpVFQtzIlEFJvBh6YUPRlNSnuEKeo8Dt5LtNWl5139bqwkGJfzkGnuetqW1tpQrNzwAg==
X-Received: by 2002:a05:600c:8b11:b0:450:d4ad:b7de with SMTP id 5b1f17b1804b1-4511ecb9cd9mr122631155e9.3.1748957811494;
        Tue, 03 Jun 2025 06:36:51 -0700 (PDT)
Received: from debian.local ([81.78.104.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fa27b4sm159437275e9.15.2025.06.03.06.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:36:50 -0700 (PDT)
Date: Tue, 3 Jun 2025 14:36:48 +0100
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <superm1@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Johan Hovold <johan@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Saravana Kannan <saravanak@google.com>,
	amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3 2/5] PM: sleep: Suspend async parents after suspending
 children
Message-ID: <aD76cCE5qyALjKHc@debian.local>
References: <CAJZ5v0jDZQaR8S6Kn_RoXHBU86+tpjp=qgyxm5h03YEe2S=nPg@mail.gmail.com>
 <aD7L0RD4HT-mEtBc@debian.local>
 <CAJZ5v0h65Gt1Fw35vp2k8kKu62+goCD8WF8u-tvhfWW6a7xHxQ@mail.gmail.com>
 <CAJZ5v0ggPHhYcdNos2o8savvq+-zpPTaQunjOkR36k3VwF3_CA@mail.gmail.com>
 <CAJZ5v0gF=ewooE0cUrNfe5_inhnzq6bqw8VTjkFwr56_wrptJQ@mail.gmail.com>
 <CAJZ5v0hpJSVdiCN29=kbV8KfgU1y1d3hFfshtBoMpVFXf+LvBQ@mail.gmail.com>
 <aD7nOMP3xA9BR781@debian.local>
 <CAJZ5v0gAcohRWuSZbFWvyfAU9Vjc7nRyj+AFRYQ7hcGEXdPxyQ@mail.gmail.com>
 <CAP-bSRbVjcXBvxDT6ZQuoRB+JF6A4LhdMVnNqnaQC0bg-xg2BQ@mail.gmail.com>
 <CAJZ5v0gTRtPzrROdkxRjTeXv4BsRyUkyGpCWmh-gHNx3X2L9RA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gTRtPzrROdkxRjTeXv4BsRyUkyGpCWmh-gHNx3X2L9RA@mail.gmail.com>

On Tue, Jun 03, 2025 at 03:04:33PM +0200, Rafael J. Wysocki wrote:
> On Tue, Jun 3, 2025 at 2:27 PM Chris Bainbridge
> <chris.bainbridge@gmail.com> wrote:
> >
> > On Tue, 3 Jun 2025 at 13:24, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > This patch does fix the list corruption, but the "Unbalanced
> > > > pm_runtime_enable" still occurs:
> > >
> > > Have you applied it together with the previous patch?
> >
> > Yes
> 
> So it looks like some devices have power.is_suspended set from the
> previous cycle which causes device_resume() to attempt to resume them
> even though they have not been suspended in the current cycle yet.
> 
> Please try the attached patch in addition to the previous 2 patches.
> 
> Thanks!

That fixed it. Passed 30 attempted suspends without error.

Reported-and-tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>

