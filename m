Return-Path: <linux-pm+bounces-28982-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 037C3ADF013
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 16:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6BB1885D31
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 14:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1984418FDA5;
	Wed, 18 Jun 2025 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tz3whW+6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4370F9CB;
	Wed, 18 Jun 2025 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258103; cv=none; b=qP7zyQ3TSr3/h1OrY02/7ZhlLs9gCz0rokF2/LLeU9wcb/+CVGa+JeX81jGETLyJ2H8u5zPQOoD0oXynGulqelfAfnbvrXEarcZDw+JyGfsvRMwFzVdiP6WY1Vo/ezdKiBNdnDf054993w9sP5UhzTCE/4E5DIGNT89xVXlJePo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258103; c=relaxed/simple;
	bh=P5bDzDbpwAt4NzAkEKVnGnsXVMLfR/Knkyugf6sSzUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOslyFqabZu1Bo3LIvi67sDoCCff+LC9HMCWQLCrT74VMpvCm2etCumA6AoDrU8E04PzkUjE0zfyvZ/oAXOX/oGfKlUv58DgXwCgern4fMGp/Wh7pJlw1Rc4TnbTfFo6Tyye2qvAQpW4ia5Kf/uyJbusHyWSDYIpypC+2VyjXN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tz3whW+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2902C4CEF0;
	Wed, 18 Jun 2025 14:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750258102;
	bh=P5bDzDbpwAt4NzAkEKVnGnsXVMLfR/Knkyugf6sSzUk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tz3whW+6QWiJ1KF9nqwxYCZml2dELY+HbVIgDwSRAwQVgZDs1wNYsgnZwArfF2DUb
	 ItTWSBKoaMHVOkzoh0c//E7Z2keXKaL0xepf58AYGZEh7VIc1qxDY7i49wpiuXbbDG
	 na+tnd6DP3yidiOYxnffIUZFDGlwEnQZYeddwhcpCd3UDfJNJys/HbfsrfN41j2/z0
	 ouI7b3yHZHf9Z8yofnf+c1uKX5fZ/Kha5ssDxoBi6EqBJZK9gGSQvFaEEl++UtOXoX
	 fr+bpW5M1O15dRZWc2kynVjqlC3AzIQjkC7ktDAVe7VF8hMAethOiB4426sbu4fwiB
	 uOIX76D5mKepg==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2e999729ccbso4045738fac.2;
        Wed, 18 Jun 2025 07:48:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlfA9ZYeGVOH07ZYzbBd6NdhmWR0Lwikx1u8B1NcnZf/+OgB5SamaX4s8PZqjyMwBi8avOLUtS3SEwRBU=@vger.kernel.org, AJvYcCWUGeDbVxlkm5slFQqiIdQlQwjF7QKZGrKEdnkuwEOrIeGQ5tgI4EDYjBM70aBAd4wBxkhcuhP8Q2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfmb3ybcrHr1JU81iOJJKSDq8XAC7ODcYPPaBcUIGPS90cjCCm
	PjXmjKtYkqI+0SCSiOTjAu1T2/R//plFFwJWCXGZVS9ZW3qelHciyKze5yJlzZWcYY0+JWq3jmB
	dQlCLc+L89CYhQZzwkJIA1uwqC1nl+1w=
X-Google-Smtp-Source: AGHT+IE3rpy1Y6yu5od9ejR7TUmfvXpd+b6apOxzi0RcxvZTM1RGxX+Gax8nFq4/lfgvDDez5ceoLIuwHvRtESe7p1s=
X-Received: by 2002:a05:6871:2009:b0:29e:65ed:5c70 with SMTP id
 586e51a60fabf-2eaf0b2beebmr9965617fac.30.1750258102238; Wed, 18 Jun 2025
 07:48:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617124900.186591-1-rui.zhang@intel.com> <20250617124900.186591-2-rui.zhang@intel.com>
In-Reply-To: <20250617124900.186591-2-rui.zhang@intel.com>
From: Len Brown <lenb@kernel.org>
Date: Wed, 18 Jun 2025 10:48:10 -0400
X-Gmail-Original-Message-ID: <CAJvTdKn6fA6abridTf1CJrr1xMT6XU9wt3R8v4LETzMRu0a_ZQ@mail.gmail.com>
X-Gm-Features: AX0GCFt9jRWP-v3yY_dQ0tGXqsUM87OrKNyMs2liqcScx9buDl8IR3SAWOuoCXE
Message-ID: <CAJvTdKn6fA6abridTf1CJrr1xMT6XU9wt3R8v4LETzMRu0a_ZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools/power turbostat: Enhance legacy uncore detection
To: Zhang Rui <rui.zhang@intel.com>
Cc: rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Applied

thanks!
-Len

