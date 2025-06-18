Return-Path: <linux-pm+bounces-28980-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F02EADEFF7
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 16:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4583A8215
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 14:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E22D2EB5DE;
	Wed, 18 Jun 2025 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMOpRjtm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3591627E071;
	Wed, 18 Jun 2025 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257740; cv=none; b=W0tAvxROpO/JekNQ/0kaIQynbDDT2f0yCTgNY3cB9G/SPVHJBdwYlbXSIpcd49z1ZYQUKGRUpKzkXM4lqkoisYTpaloOjIG5qD0vXUULGYozpElLvFyeRPEIf3qX9Vi8323RCy5AkdVNqz7fjc5RdhZ3yNXCZhGivub0jvA5caU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257740; c=relaxed/simple;
	bh=/LLJcAe5/zdScdfm2KGp0cZ0jHfyTz8snmjc0Q/iLYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1gJ0hClNf0h7qlyPw/+j+OoECVXS4+aAAIr+Nxk8geAlsd/pfqkmP9olLqF0EhjdHCiczoZNw5WBF8v90fO6n+y+Itf3H8ZaiKr80TSBHXdUB3xqj6KNEQACamyvbQYv7rHBeP9N/FA6Glo/5y997D0EHPTyT2sFkccgzA8KxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMOpRjtm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADBAC4CEE7;
	Wed, 18 Jun 2025 14:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750257738;
	bh=/LLJcAe5/zdScdfm2KGp0cZ0jHfyTz8snmjc0Q/iLYw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tMOpRjtmxYOnW8VnhfLadWzYqXZ1ywHR18D3CJmoWFEHo+3VmUNWU6WmtmSCePsOl
	 0/b0pb+3DoRDxU9FoAsDSuS2yT1ltZ8zTyO4/A7HYvWgXsPsgpTiwdRqgNaKUDV7QO
	 TeafoNf3qCZgg0s5WxerQCThqq0+GVToo9BL0NyKwyu+gyV1m0j9yAjDT3gI7GfLB8
	 5XlIj8q/4yEDYpP2rySHLX1SL0nK5v+FK2bt1OoL50YrLGV602msrWc931SzlDgAgj
	 LkDCo4L9JiLay9j3+66E69tgh7kvJuRlYYdI0QSKhxWvHtSMtuRM1pCDNP+3kth0j+
	 0tVHlBElA4cTg==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2e41064e247so4213197fac.3;
        Wed, 18 Jun 2025 07:42:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/hBV9s5gWom+w2KPjFZJL3D47QL6Qud3OxNzOCcx5r9UQn+v0zb/FWbIm1k33uqtJ3Dl+cbCLECYLTtg=@vger.kernel.org, AJvYcCWFcAZv5CEuDD9hHdcAjtpel7AzfR4EGYSRt78dT4P2E1aN7XeN9jNMc0rE55AbNrMG8xexDftHVQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7x4TI3sUAp831AKgn2n3Frawz72j4TM2UW9apcbT8IYjOGfaR
	HHrQgsZc7FJpKcNE30SUFGVPKNGIrEqwviG53YqrbIb7ymmltaeLxxWMkFb2OtkrEyaHWWUi9xW
	bAvommyyJNl9ANs6zHgKc13+V6amQXSk=
X-Google-Smtp-Source: AGHT+IGpgOpDQygUIj1fU+gp8KStz9qq+H/Qqbi49JloZ7xTYmgKFrqUZeo9dOjP1MZTqES8p86zAKCXEq8G7RR2Wtk=
X-Received: by 2002:a05:6870:a70c:b0:2ea:7d72:23f7 with SMTP id
 586e51a60fabf-2eaf06932c5mr9937089fac.16.1750257738209; Wed, 18 Jun 2025
 07:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7edd4c688111a697cfe913c73d074738b3d1dffb.1749833196.git.calvin@wbinvd.org>
 <17f85f0bfa5446b86188616349b17d02fe207c22.camel@gmail.com>
 <7325c49d7d2c407f7391ed30e3a7e0c8898bf5cb.camel@intel.com>
 <aE-T0cZsdoCZOD_Y@mozart.vkv.me> <6e18be89b937fa8fd2cc917eee6b3cd36dd26d56.camel@intel.com>
In-Reply-To: <6e18be89b937fa8fd2cc917eee6b3cd36dd26d56.camel@intel.com>
From: Len Brown <lenb@kernel.org>
Date: Wed, 18 Jun 2025 10:42:07 -0400
X-Gmail-Original-Message-ID: <CAJvTdKm6At-SxqPHi04vdrn4i2Bn2=bN3tTxVXNqTLx2MmoYgA@mail.gmail.com>
X-Gm-Features: AX0GCFv4RJFYUBhZx_EjX4nxzFKB_Yq-esXmWW6JO-15d8E2AlAhb4dph3YU4PM
Message-ID: <CAJvTdKm6At-SxqPHi04vdrn4i2Bn2=bN3tTxVXNqTLx2MmoYgA@mail.gmail.com>
Subject: Re: [PATCH] tools/power turbostat: Fix build with musl
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "calvin@wbinvd.org" <calvin@wbinvd.org>, "dedekind1@gmail.com" <dedekind1@gmail.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Applied.

thanks!
-Len

