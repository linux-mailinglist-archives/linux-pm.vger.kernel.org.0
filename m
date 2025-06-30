Return-Path: <linux-pm+bounces-29853-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E90C3AEE6EF
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 20:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129BD18817D8
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 18:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1809292B24;
	Mon, 30 Jun 2025 18:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkOeEFum"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF9723C4FA;
	Mon, 30 Jun 2025 18:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751309035; cv=none; b=qwTz/A1GXr/BWwmwaigal/CRITi7Rufpg8fiTzR9ketcMhcHSFpa0GofDLOwJmlvf6TX5EHSmCMQVEk+ARqqX0BzRWY27jwyMEL0mqROYIGyAWaAh6a8a0Hql5sp8DbrCk71Cw5omjSI7X+BXVm3q+hzPu4RdMHjzJsl3g17f3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751309035; c=relaxed/simple;
	bh=aFSIbwA0Obs5QTHKNt8wYCpB5FVrzEDjx2aUoocbr9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWihqo4mujlv1Yyd0sGWKaaZ8KmbcMDz0gq9kywHoy4/xX5qUzDyH3RAxmT2e8FBmZst3eIX7PNS3076WntXem/r1ca5s2mthOHIn915KFDyT9zD7PVvzm9WpgMMlfHL7jxy7Jm8tEODFmUY/J2TB2LdkGsd2jlocH1Cayvsv5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkOeEFum; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-553cf020383so5410321e87.2;
        Mon, 30 Jun 2025 11:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751309032; x=1751913832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFSIbwA0Obs5QTHKNt8wYCpB5FVrzEDjx2aUoocbr9A=;
        b=bkOeEFumHtVdi0K3Ku8qM8LG8DUpLsPmDbhg/0hEEwSWjYBnZatRSG1NUOrj3ZuM2V
         Z06R83W0L6Orly4J2oNfRYufyGuedlvSIcRJPiaqSx0i9BHP3J/Y6OXfOEaCliiCwnZI
         ZDyncefWcwyg/kUqNQ9KnsvwHEhZuOTWcJp2hoOC/DkBA2Y2RA5HPzyWSXa4SYdT0YZN
         nQAZ5U2w3rtmxIwbRi0+ZYU4sjIUnUuH/Bh/KEH9S+vf0bSmKWPnrEPahYRK9GZOTz0L
         mZlm5WMW1e3d16EwgaIzSwna+cN6Hp6cbWQYyWEV556nkKeP2AI3RRCjJ5RH9vyOhU9G
         GveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751309032; x=1751913832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFSIbwA0Obs5QTHKNt8wYCpB5FVrzEDjx2aUoocbr9A=;
        b=fNzPMCkYTpf5TFRQzquAPQ6I0BEnBEntMjCx1IS9AANE6QZ5BS35fATsFa7YDvFwbE
         UErwNHrKaoqz9dCTXh9zO0KGz1S/2YhanBNMXJitWJwEGHAxGrHbtBeXP1PWMj/XfSKg
         QAAfH1wIsabljJLjT6VNMehfGKPqhPmazjym6IDyK8VRlYKqrTMtpvnAsBlxAfpXE3uz
         TsKd6Yf5AX4rO2UjP3j+o1NOAiisYMNYN638ByL0v+4Gbr27ho65Fok4yv2dhenobTk7
         xNmWrXWhQwW6eoQntk3LiaJ2ZzeBK6RQB+C8Tr8ZJeluPmpcbbHPwejxLxstKjEddaqJ
         D1UA==
X-Forwarded-Encrypted: i=1; AJvYcCVgFB4yv3tPYryKh0r/1bLieNcxPeXfieHBCMtcIZ5K5uATd3kkZBPlytPVkvRvKbXgJpMlfwuQz1vts0o=@vger.kernel.org, AJvYcCWYYynIM7xA4muNxpvcORyDFChFOPkKvOkDZx4eKUICh8uZ1X0q2Oc43IinKYccPAEaDBHoH41QRYw=@vger.kernel.org, AJvYcCX0oxWBD6iJHP8wAMMS36DounI8i9aWLikNrrKaAmxx44jajLkBq52+W8B4sD8y7qwMv67wjSkhBd6ypqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZSjrvxE4rAlrH32fxVbANiccmY3UF9wQzGVkQPgRfXB8tDzh5
	fSF0HdGBWod1TIVa4GyQSxVzBlZ505/STBB1Is13W0+bVR7+TuXiRXKhc8gxGKPcPUPEGGnwLrJ
	DVBbBO5DmPV7fKHxg/O9APBglYUIaQtw=
X-Gm-Gg: ASbGncuxxnVCFbzzknIf6B4/+xBru09rNYvViFWlc2FnhTjHo17rEMEs/OLG8c2i3ZL
	snrjjXWBH39oCblPKtzjLp6/EfddePu3mkzGk1sAXgnWZkqZKYhI5kEixPBodTG8fjcPQ9FgH7v
	p1pr1s8VSUXNTW/ZP/amgB85d7KzK1Zf5yI5AW1mD6Jr4=
X-Google-Smtp-Source: AGHT+IFts7B2G94g1BsJej0yK8agM1bwVzu0mWbSXDl/5ZEwOcpHgL67IjAqouLat6jwnKktyvp8cEJm7vvx5kQIH00=
X-Received: by 2002:a05:6512:b12:b0:554:f79d:ce59 with SMTP id
 2adb3069b0e04-5550b9ee228mr4566554e87.27.1751309031764; Mon, 30 Jun 2025
 11:43:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
 <20250508-tegra124-cpufreq-v4-1-d142bcbd0234@gmail.com> <040b0d8b-e862-48dd-9b77-9266a5194f99@nvidia.com>
 <20250519101725.k644wzizjwygtwa7@vireshk-i7> <49e7d006-e9cb-49da-a4cb-b73a08f6b792@nvidia.com>
 <20250520100218.te5i5ltrx43zjsq6@vireshk-i7> <9826e66a-3474-4a00-967d-b7784ff60be4@nvidia.com>
 <20250605105151.5s6eblr472mbhunt@vireshk-i7>
In-Reply-To: <20250605105151.5s6eblr472mbhunt@vireshk-i7>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 30 Jun 2025 13:43:40 -0500
X-Gm-Features: Ac12FXxHvk8KZYtykBjWMf5LNIhZa8_RViROFbSfDc-CY2-mP9QdqIlLFIs5w1U
Message-ID: <CALHNRZ-uA6vHYbb5UdDvhRrNy5j2jyds4iTsiOxc6O=2nnedbg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] cpufreq: tegra124: Remove use of disable_cpufreq
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 5:51=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> On 05-06-25, 11:34, Jon Hunter wrote:
> > I think that would be fine. Given that the tegra124-cpufreq driver is t=
he
> > parent, if it fails to resume, then I assume that cpufreq-dt driver wou=
ld
> > not resume either?
>
> There is no resume interface in the cpufreq-dt driver, it is the cpufreq =
core
> which resumes to doing DVFS and I think it will try to do DVFS even if te=
gra's
> driver failed.

In my opinion, I'm thinking the original flow makes more sense. If
resume fails, disable cpufreq. Then the subsystem doesn't keep trying
and failing and causing who knows what kind of havoc. But if that's
still not desired, what should I do to get this moving again? Just
drop the error handling entirely, as suggested?

Aaron

