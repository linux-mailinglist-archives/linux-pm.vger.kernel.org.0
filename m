Return-Path: <linux-pm+bounces-20464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F053A11B73
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 09:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548DB1886034
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 08:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D4F155C88;
	Wed, 15 Jan 2025 08:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cQGHFmHg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5C11DB153;
	Wed, 15 Jan 2025 08:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736928190; cv=none; b=H8GEfoja8kqjOd1yCOcifCn7LUUJqRIBX1I3IbznBX1ert917OaQGjVSHwcoq02O7MY1ivBCoCbuqfdNESyQ2zbkp4QmvgbF3AikBLfh3gsl5yP7KJcudQQc4LA6YsjDlmre2OWS9WusmxlQEEKkl8wX34Bj84oBue71FqyveE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736928190; c=relaxed/simple;
	bh=btAvYlqyz8ra+2eSys6t/19T2wzcd8CHMd6rRAhIANU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVcJjfC3fdecKg1zNdF++ZbX1UzNnHcuX0OK80GoBuHWRcIVO/i+3VsTUWcLewjcjGtEwPL2qdKN+DVlDCK9zD9yAqRWgp2X6PdZL1nXB/y4cekoNQbaMFBuBSGoeUTmPdehUhmkQn0x6jR+h1XtjB1sEI+UmrJX8MQw8r0GJRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cQGHFmHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623B6C4CEDF;
	Wed, 15 Jan 2025 08:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736928189;
	bh=btAvYlqyz8ra+2eSys6t/19T2wzcd8CHMd6rRAhIANU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cQGHFmHgzWFEC2oeNcrPJRNKkhBTS+UcNtBwf2ENIUe/VTShS6ODpxUOoy4Tf409v
	 5sC/Lr7WpPXlKJuYbFYdh3w2xQGxn61X+DkZaD/rjQ6v3V/2YmdYptxn8zFaRbj5qw
	 UmRErLYBA5lldndNJ0lFbPJDDLSU6JD5NHwaRuLA=
Date: Wed, 15 Jan 2025 09:03:06 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] pm: runtime: Add new devm functions
Message-ID: <2025011529-luridness-heat-0755@gregkh>
References: <20250114222851.1023194-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250114222851.1023194-1-csokas.bence@prolan.hu>

On Tue, Jan 14, 2025 at 11:28:49PM +0100, Bence Csókás wrote:
> Add `devm_pm_runtime_set_active()` and
> `devm_pm_runtime_get_noresume()` for
> simplifying common use cases in drivers.
> 
> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
> ---
>  drivers/base/power/runtime.c | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/pm_runtime.h   |  4 ++++
>  2 files changed, 40 insertions(+)

We can't take new apis without actual users, sorry.  Please submit this
as part of a patch series that uses it so we can verify that it actually
works properly.

thanks,

greg k-h

