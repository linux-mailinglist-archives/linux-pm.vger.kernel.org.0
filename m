Return-Path: <linux-pm+bounces-36056-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65040BD8BF4
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 12:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E111E4FD651
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 10:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3482FB0A5;
	Tue, 14 Oct 2025 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZC3gkKSE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7742FB08D
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437418; cv=none; b=oP5u8d2K9UwE+S+FPhPPvTF2uAnMbSCxLwCKZ3WxctJS5RG3uD6AgPVWhsBIZhEO3bQTvHQnRITKg8WIb6tMvwK8i5BuPoNOxhjGcJccXQU1+9upCTNJeC1ZYlHxO3tka+aHoSsLIO/ogOp5QE9N1Q90onF/HxBZRnbepYil/2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437418; c=relaxed/simple;
	bh=F7iiiWJil8lr5Lg9OzDGeEMXA53iTr+8fK8leVqtgTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbzaFyVrV+kxeSckbBPmMiRn73eMjyi5O6WWMCoCAFWo2u8+EASp9Y/kIyxEFOgIE67U7nD0FJYBqNBD9zz/5Z0s6GKkKzpNPXHGcL7psa5QDbDOpowUgutflfKFHjZOwgJUncRaShYIUYUcZ4RmrGxwLnfPsIS4TfljMctjZF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZC3gkKSE; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7811fa91774so4427431b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 03:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760437416; x=1761042216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mvbagg2IA/uXkd0ZT7M7sfHL3n1Y94M8PIPHMNkPsa8=;
        b=ZC3gkKSETaikfQDjJqShfBhmNClkRR0Zegvauv27h7UUWm1O3jYeQQF6O/Def66212
         jihxKVyINcs+VguybUsd+O1UF/GmzodogA/v0ToBUpG4rN8Fv9Pa1YeaSR2TN2pgaIUH
         jglbEweCEzG+AV+uukz9KpuNPoZUhw5xsZACc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760437416; x=1761042216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvbagg2IA/uXkd0ZT7M7sfHL3n1Y94M8PIPHMNkPsa8=;
        b=TY3YMCPm/+OmOzLqy81rS2xPYayRKnpYz2L0koJWKcmrn0NWGiVH51cfRgIbYNCQCw
         l4ssg+deq6+z/jgALAh5WwXkYBjFDnmFte4bLMnsSS8mkZdLSzlXn7YXaMgYjH1ZoGCA
         BEWGsHMc9STfuPKj03BrgwFdjwKQRMC89qkYGSrHRPHQhObOYUzh/C/wUY5NYEndFe67
         UFEo6qkfHaq1BD75UEXGKcRStIZYctUatWlStXOO08QGofmA2Ok8vNjDSnz9EG8JrKIR
         LSmowf3KSCzItkDcHM/4xr/JtXycAJ5R8TdY/j0TfVOxj1av46HHlLowX1TfGbkD8fCj
         pnXw==
X-Forwarded-Encrypted: i=1; AJvYcCUtYBtQVIDJemxQngE0oNJtqDU61epTGagP7KyudPxlkrCaJfA6zdESZGVc9dlTYKaK7lDtQb90qg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1mctzN+22GecoNOk0KohwxLHWo9E9cFoqnelmqxElqZvqIorD
	YAA78iICa1eo+YPA7zJDK8V90mwEbQUuiqfArrffAthry0KW1WE+rnPkrFhzS/VKow==
X-Gm-Gg: ASbGncuQvNoWFv+nvgZGs2yzz+DVX+e6+4oL3czHLESveEAmbfUc6Lu0bZ+unHZHC2u
	2gmJQ/xVgJoVOFdaTXYtDOInvjxWBD6lLQxalguxDOO+IpXjoAF6kclC60d4uUV9uOBQ8pyGf+H
	blqb0YBrcEuLcY2kuS/27ixyWSSmc/uAnUmaeOZ5JgLe59Ew0in0kXtqNAFwRArJ5fU7yR3uwPC
	jwsuixUeUuol/lbEdwBQTdDhd4dOpwxDjxzltKr2plL6vPsY4hmKl+5sdsIIgpUZaMC1M5ZpEzh
	NmEinUS6Q+uj6tgxa6r5ThcEEPe1eDwemUJZWVI/2Q7Y9zOHSOqHTbG5TH9umx9ojEO8zBAwcki
	V3OqkspW/NmfZ3Mn1tKYV7ddBTyf7HEnM0U27qUAajbhKzKs75wzPeA==
X-Google-Smtp-Source: AGHT+IGASm576xQ/Y0lTqK/5/WEa24uOVhXlkqIYz6pqxQzAQiPqX+MD5xHt32UH00HFngJv6L/bsg==
X-Received: by 2002:a05:6a00:2d8f:b0:781:2538:bfb4 with SMTP id d2e1a72fcca58-79385ce2724mr27606408b3a.10.1760437415991;
        Tue, 14 Oct 2025 03:23:35 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f7c9:39b0:1a9:7d97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0964c1sm14398178b3a.54.2025.10.14.03.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:23:35 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:23:31 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08529809-5ca1-4495-8160-15d8e85ad640@arm.com>

On (25/10/14 10:50), Christian Loehle wrote:
> > Upstream fixup fa3fa55de0d ("cpuidle: governors: menu: Avoid using
> > invalid recent intervals data") doesn't address the problems we are
> > observing.  Revert seems to be bringing performance metrics back to
> > pre-regression levels.
> 
> Any details would be much appreciated.
> How do the idle state usages differ with and without
> "cpuidle: menu: Avoid discarding useful information"?
> What do the idle states look like in your platform?

Sure, I can run tests.  How do I get the numbers/stats
that you are asking for?

