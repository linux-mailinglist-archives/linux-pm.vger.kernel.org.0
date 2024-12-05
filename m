Return-Path: <linux-pm+bounces-18635-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAC79E5D69
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 18:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888411881F52
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 17:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA2E226EF2;
	Thu,  5 Dec 2024 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/idgI43"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED3D21A42B;
	Thu,  5 Dec 2024 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733420194; cv=none; b=cDS2W2GxgMsWe3eipANwp010z1woHBo0fmcbmGmkL/7L906YgJYWRMtvk2l/hnzeyqXKzKBA5Zjg8/2P2AHFTVBU5guOlzLhBjaGq+rpAdhQLxz0UyIP04MSjFiuQCx1pgeitEu77ybaIuv8vkumcFWeHFW3Rmrq+rMgsMbjDg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733420194; c=relaxed/simple;
	bh=JGtrVDKRCTfsW1j6f41xR3O+h6gmlQFHESW4VQ0BzHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqCxcDHAguLSlvekfoAitdtshlIJ4zdqfvkz0l9BA60oQrERkOVf7ZiRCz6mXRGhIXdc0KtTcqMi9OUWMn5chUKsr8LoDrJ+pSdrrJ3OITZE2OubtnFgoTPMBcqSs0zbvE4Mg2PMcUPY/aHJN7prSh8A4T8pBoSaO9tDPpEWV0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/idgI43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D1DC4CED1;
	Thu,  5 Dec 2024 17:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733420194;
	bh=JGtrVDKRCTfsW1j6f41xR3O+h6gmlQFHESW4VQ0BzHI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A/idgI43lStIjvw5uTUH9zEIdCm5sCLRcVpEMHBwFFF4BakL5WaZ82sUL0K4BZjIP
	 YJUueQQ57ETg9WB+dO2JWIndXrEL77WJQvodI5lxDW/4nPqNoOYic/s9yd3vxg2CQi
	 c7L7L5muihGF2xd0WCSTqeEl3f79WZNrTgGRUaUOJXfJAIsNkidr4aDRDdTFY+ePf3
	 lf90fDjeRes553o7DzjFG8mwULX8seDulgBFzNRzWppz33t555YcALTB2dciiR7uQp
	 baxvQRHQz02qfzHjcBVNt54N/btpQpUW/J0LKR3JFz76n0PWNW8JAZjAUe6fvwpRrt
	 biHycSXQJyiEw==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-71d537b50beso659866a34.1;
        Thu, 05 Dec 2024 09:36:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUdfv4hqPKX+8Uz7e7x+durCY2M3Plli9xHCzZcX2OnB4uUTjkR3pg6DQye3p2MTG1RExKt7p8Spb0=@vger.kernel.org, AJvYcCXiuJFY4TYcX9F88z0/gf/qK+gWasTuA6XAVItl6Ulq0CNATqmfOE59Mwmpl7Uge1ijwyteRTGf75RUJxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9qODjM7pEBQ12uszI83kGMKy3iPUoUk25Bt8bTA7MdNA5j9/D
	YQ0tBhtWUXJqlk6zpxHoxZB95hfcIROx5FbIgnRD69aDPCO6VARsHAZRVXSXpvKJtY3CaIyQnsL
	IejoC/WX5HLWafoXiauMhwjTXAqI=
X-Google-Smtp-Source: AGHT+IEBBn49vpMRi+OzmWF5NaHdcOG3lA43Za6HkPJILYov9Ikrfyi54ZLt5Pc+sVMks9eTk5pjh3+W+LVINd2aB6c=
X-Received: by 2002:a05:6830:43a2:b0:71d:421f:5bd with SMTP id
 46e09a7af769-71dad62d728mr13962500a34.11.1733420193555; Thu, 05 Dec 2024
 09:36:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <08f3bd66d7fc8e218bb6958777f342786b2c3705.1731554471.git.len.brown@intel.com>
 <CAJZ5v0g1JwGRECd2JVKScWO9a=hmrY03YQx95JKZ+q5KisRb1w@mail.gmail.com>
 <f6621a09-d5e4-4d3b-9b5c-55294c22030f@rowland.harvard.edu> <CAPDyKFoJ45PZ_o6VdaCiyat+BC6XOZ5AMnxmsZVzk16cCxmDkw@mail.gmail.com>
In-Reply-To: <CAPDyKFoJ45PZ_o6VdaCiyat+BC6XOZ5AMnxmsZVzk16cCxmDkw@mail.gmail.com>
From: Len Brown <lenb@kernel.org>
Date: Thu, 5 Dec 2024 12:36:22 -0500
X-Gmail-Original-Message-ID: <CAJvTdKkqO5D8tZt3L_dbXkXftUOz+zijEjQiWHginn4t_o4gKQ@mail.gmail.com>
Message-ID: <CAJvTdKkqO5D8tZt3L_dbXkXftUOz+zijEjQiWHginn4t_o4gKQ@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH] PM: sleep: Ignore device driver suspend()
 callback return values
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 10:33=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:

> ...I also think this looks a bit risky as the current behaviour
> has really been there for a long time. Who knows what depends on this.

If everything were working 100% of the time, no risk would be justified
because no improvement is possible.

But we run over 1,000,000 suspend resume cycles per release in our lab,
and this issue as a category, is the single most common failure.

Worse, there is a huge population of drivers, and we can't possibly test
them all into correctness.  Every release this issue crops when another
driver hiccups in response to some device specific transient issue.

The current implementation is not a viable design.

> A way forward could be to implement the change as an opt-in thing,
> rather than an opt-out. That would allow us to test it and see how it
> plays to potentially change the default behaviour down the road.

The default is the only configuration that matters.

Len Brown, Intel Open Source Technology Center

