Return-Path: <linux-pm+bounces-15535-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFBE99A146
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 12:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30FFE1F22A6B
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 10:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB03216440;
	Fri, 11 Oct 2024 10:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAXdd8BD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F72C2141BD;
	Fri, 11 Oct 2024 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642344; cv=none; b=rsCwta1RSt6boDqsU9/yUQjYFIHk15/0i6KKOonMPrc7G3zxzE/8LI0tOXDC94GQdEUU0ywJvaAXY1Eqklqv4aQaDDQv632kHMCdKctQw8Tf5yuYcbsy9ad6CGZv0YDFsysdh6A5LRpra1y4wagBT4bbAH7nhDTcNQ4BT0azxFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642344; c=relaxed/simple;
	bh=5Bn7ngZJW3LBa/gYlkIJl17Lw1N5Eu2tNA3hab6Hz/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgw8tQqva/6KQReOBvSUzNo0SaQDRvhklhvuieOA9ZwIlFqIn5GkiPlctTfGnOsO0bUtkIhRCzsixMKY5FST8WMhHUBUIm9svJy5/G5ukjlQkUxgoCTtpsUt/v/5nhF6f+DAJGpRImTZau9X0L1uec15FanQ7/ykznhTN2sKSBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAXdd8BD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38E8C4CED1;
	Fri, 11 Oct 2024 10:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728642342;
	bh=5Bn7ngZJW3LBa/gYlkIJl17Lw1N5Eu2tNA3hab6Hz/Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gAXdd8BD4VOEfuPzd9wLwMRqEFdEFpB9Psy6VdBfYcWH2WthctQF9CqmyAoZg0Rn6
	 CGMVx0tqCsZ5Vvzfw5Wum14JQanACsKjphuHEobmXFZnyH2rm3HgD46dch2+zwsUwZ
	 3YIqX04rJZBJbLz4kW5Lf4BfUqlRc3qAJSu5PAqt58hNvuxYt4RiOF1+9dFQ1rTXI8
	 Eqo33CjOdN+fSddBLetXy8mYDhEkvtSGQWWU8K11kPE5S2DkGj9192uLbTfh8GoGZg
	 qvbffuoPkxrftCsCdYah8+FZNQXd/xHaikxVL6yOcin8Wao9q+6Xwx65MDLeh0Mb1S
	 PZNl9r+hEDAPg==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-716f9721ed0so936730a34.1;
        Fri, 11 Oct 2024 03:25:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCVyXw48CUVeoiNjqmKWh9cJRILEwdXyF7oT2wDv9bFGyJQdo7usa4JWhjSB62XLQuTiHVVyFy@vger.kernel.org, AJvYcCVZPA7i6BK2p7p/xLxOj1hRtLHYRnANFH961iWrzxSbdaF2W/G08KaNmnBNNUmXAMZmuelhHqfjlHk=@vger.kernel.org, AJvYcCX58Wb9aJ6nRoirfTA4X5FHc6K9fioQ7wEyBwNU+eVxQLs7A52PjKdxaitAfDDYzPpFmGqJT7ZP75H34Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7mcQucT2j16sjcJ6QRCXcaclVqKpEuXUTVgnWyG1JGXJaBnzV
	qedCxu61ZXTibJHhD1GYIyWusIJU+AbZyTf0SGANoOfXln+uymVRp7M/KFaDALWdnx9nTsuE5CH
	LBEUlcshknZ4V57dba/lfNtDzp9g=
X-Google-Smtp-Source: AGHT+IFXmbS5nFxJANrK29sR08R9J3f4mYiy8JY0oLyd1mfI5MmSCDoG3m/7Zfk7hn2Pc3mEqoE1E2wJdZx82mUICbU=
X-Received: by 2002:a05:6870:d249:b0:288:23a4:7955 with SMTP id
 586e51a60fabf-2886d885d67mr1255145fac.21.1728642342109; Fri, 11 Oct 2024
 03:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009072001.509508-1-rui.zhang@intel.com> <f568dbbc-ac60-4c25-80d1-87e424bd649c@intel.com>
 <CAJZ5v0gHn9iOPZXgBPA7O0zcN=S89NBP4JFsjpdWbwixtRrqqQ@mail.gmail.com> <edb18687-9cd7-439e-b526-0eda6585e386@intel.com>
In-Reply-To: <edb18687-9cd7-439e-b526-0eda6585e386@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 11 Oct 2024 12:25:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hF381EHwO7AECgOM08kAQjppq3x9f2e-UHQYdYySCwBg@mail.gmail.com>
Message-ID: <CAJZ5v0hF381EHwO7AECgOM08kAQjppq3x9f2e-UHQYdYySCwBg@mail.gmail.com>
Subject: Re: [PATCH V2] x86/apic: Stop the TSC Deadline timer during lapic
 timer shutdown
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	rafael.j.wysocki@intel.com, x86@kernel.org, linux-pm@vger.kernel.org, 
	hpa@zytor.com, peterz@infradead.org, thorsten.blum@toblux.com, 
	yuntao.wang@linux.dev, tony.luck@intel.com, len.brown@intel.com, 
	srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 2:43=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> How about something like the completely untested attached patch?
>
> IMNHO, it improves on what was posted here because it draws a parallel
> with an AMD erratum and also avoids writes to APIC_TMICT that would get
> ignored anyway.

Please feel free to add

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to this one when it's ready.

