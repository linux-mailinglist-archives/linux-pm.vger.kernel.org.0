Return-Path: <linux-pm+bounces-4581-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B045686D8EA
	for <lists+linux-pm@lfdr.de>; Fri,  1 Mar 2024 02:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658521F239C9
	for <lists+linux-pm@lfdr.de>; Fri,  1 Mar 2024 01:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D252B9D9;
	Fri,  1 Mar 2024 01:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ykJWl70F"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D3FA944
	for <linux-pm@vger.kernel.org>; Fri,  1 Mar 2024 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709256864; cv=none; b=plmlg32SZoi9+J0bed2/GrhPgqY6vTqpzKPnPsgk6qhA/s3Js0nKxAIvpJ0BDuFHjAwgNqxOo+O0dglYP8v4Blp44t7oxiMauOd8KREFi6Jl97taDT1ZKNBsNfHeuvNE7jT8MHsiDjVGo3yf+0nToqmtMGVE518l6KbIMYVmlp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709256864; c=relaxed/simple;
	bh=5jxGk13RlQzgitUUJLTFrFi0VZ4QhsC69zmXm6F+KAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h49zqbMfRIgHM5FDLrgNkInHUX0N4KneJM8lxONF7fzFYNObgKiI0dtHfFH7ki7hl9p/FhsCODdGzL4xaHQlMM5tzPl21vT7wkiCtpfjJXnJITCLKTzw1ZBmlOa5yE5AauA0pCMiLhX194kJq779MQ524IEnrZH8wnoS+DibozE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ykJWl70F; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709256861;
	bh=5jxGk13RlQzgitUUJLTFrFi0VZ4QhsC69zmXm6F+KAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ykJWl70Fw2sqKiAJwZwQMkCI0RkMSOYuy79jYwNoQg/m/YGL+wAt0yea+McjukBdd
	 tMxr5PNQ6bMHFAyVKtMgy38knyUbtibgR1EBmW1gMxtRbM2BPOyAZriF7twcPiaUPP
	 HZpxQ66m+vFVfwVreOyu707Jtul+0RZC4rhuk6IPTSFNy+AGZm+2dzQkCrTlhbSKzX
	 FSxu3XFfHQDGL/QcKbj473+2wNz2Jk2+LaCXgUo+FY1VP0UVaanZUQetDPGzLESQ7O
	 7xXFNC3yfJrCDRSgG0ozcdWmbjQay7zwcwH/MlqXr8I0vg79CNdzbx0UFXXQyYvWKp
	 v1P2gqipnOEPQ==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5ACA037803EE;
	Fri,  1 Mar 2024 01:34:21 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id C21A510671DA; Fri,  1 Mar 2024 02:34:20 +0100 (CET)
Date: Fri, 1 Mar 2024 02:34:20 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc: linux-pm@vger.kernel.org, maemo-leste@lists.dyne.org, pali@kernel.org
Subject: Re: [PATCH v3] power: supply: bq2415x_charger: report online status
Message-ID: <in5kbbi7in2kcurvl5jppiztxl6ly5yeys56ghamenkd2vdw6j@wjxwy4d3wa22>
References: <20240229063721.2592069-2-absicsz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229063721.2592069-2-absicsz@gmail.com>

Hi,

On Thu, Feb 29, 2024 at 08:37:21AM +0200, Sicelo A. Mhlongo wrote:
> +		ret = bq2415x_exec_command(bq, BQ2415X_CHARGE_STATUS);
> +		if (ret < 0)
> +			return ret;
> +		else

The else is not needed, since the if returns. I dropped it
while applying.

Greetings,

-- Sebastian

