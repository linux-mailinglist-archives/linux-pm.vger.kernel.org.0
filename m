Return-Path: <linux-pm+bounces-24450-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1922A6DA25
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 13:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CEC41894386
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 12:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC2425DCE7;
	Mon, 24 Mar 2025 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKDAQAFH"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1922A1D86F6
	for <linux-pm@vger.kernel.org>; Mon, 24 Mar 2025 12:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742819529; cv=none; b=WObHmsj51I8691WkaOoCURJK6ARQOLooiEDFcySxQ5Kj6zeMPh1zy0WVJ8YRHWnx98ru2aYa2MW9mkXhPed6nCSLAZXKeMewNtAoaFzqdv+4xRaZ3ETzeSawpY3gKK9wSWigqJMIAkNmZNsRZi8ncuxVe4e4P7VECUdnIt3l6Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742819529; c=relaxed/simple;
	bh=KW5Aw5zPxWIfey3C2kZHC2uTu5mi3pFumurzo+narCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJ6SDOXK+DrXUhFAsHPCtJg4OamijECXMnArcrJVDi0bfvDwvPnl/yNqvF0MUHeuCLjQOdSbNnaxOTQ+AHL0chKJGJk78YxCZNyPijlXpmG/HknSH7VvFwqD+UFxGcFoU3jU006OPPRfndYwIMx3duk0Jw512F3iCKydJZL+bf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AKDAQAFH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742819527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gCZm2j6VgR31/Jo73E4X0cDwzfnUjTVV3zsHPrQ3334=;
	b=AKDAQAFHh1OHZtLI5KJqPMMZ+gv5nHjNdzwPJGnJ4HV8rSk0OoYpd+BFsi7huzIoEBMJH7
	EkX8kZyO3XW6d7FthFsCJrHxC0DCJHPuK1pbumhtHNAVzpIx5X/2pbFByvYz6xh6EaCZ6Q
	eA/7/6K1waSk8I1fVC9uub8HxkHy5LA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-7ZfK9mvSMz-jaBApkYkyTw-1; Mon, 24 Mar 2025 08:32:03 -0400
X-MC-Unique: 7ZfK9mvSMz-jaBApkYkyTw-1
X-Mimecast-MFC-AGG-ID: 7ZfK9mvSMz-jaBApkYkyTw_1742819523
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c53e316734so853912785a.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Mar 2025 05:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742819523; x=1743424323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCZm2j6VgR31/Jo73E4X0cDwzfnUjTVV3zsHPrQ3334=;
        b=S1aW/JEwssW0bWlrMHoM4pWCT88OyO5+4rGn4mE25uQOIqFKjEOKiatGgygJas7Fiw
         fhfHKr4LXLyLCE3jUgF+M3HG6PpCIQ/r0uJIeBPcy2sM3EExMpAxZXQHCZZ2cuMGRRFy
         A5aEcZ+/iQXL6svMKCsXlk9A8fKNWdhb7/D9uPX7SoEEjY4OiO4jNJKlECOlRur67Ra2
         0mGdZ/z0BEGTzkXQUOc/FJb/zX7NeVelUGOEYjB/VxOJ8ICp3A9mykSrhE8TuEUI9wSv
         wxaPZISBIEFiuMZ0dsmZZyMRg6ezrd1V5KnceZ12VpISNZUMb1L6L8U4StfRjut8j/JF
         UVQw==
X-Gm-Message-State: AOJu0YyFf+582GaxRnUc6J1aNJksCUKbstolgy6O/jwZ8hj/6NyHjcm8
	MDwIZj3L63HNUQN1mmvD/HBemwcMqRR/ddEImVEStQKqq/+swObdZQ8S9Kg234Yq0d2lcTku15h
	tTQjfLRL8539UnKd07Awb/uXV9b6h5QwEzbT2Vijtpsl3NSMedO0h1X5+
X-Gm-Gg: ASbGncs+sgfCc9yKY9Jz45ly6bOwTNmrzyOLIQlpI2PXQhXFMLDDRCCVqpLtq1LR5bT
	s/K4WL4kJguInprQwIjPYwUvCKwOtX34qlWveNeXl2wUi29JzK7aHMMJAxrzgtcXOPDquXfvsnS
	9bByLlgnp2d/i6GdOcKA6pluH6zgt05MMXO2QUhsrJiXISGPseuyGPVlXgXpVnj2kEJu9Ug5Bfm
	aIJF1F1Eu/xSM4IzWxVdU+we2q/py/4YmPQMucI9yeBKPZadYIYQLZCIb3ZqKP+SrQX0gTPs4JM
	4D12IV5HBLNK
X-Received: by 2002:a05:620a:bcd:b0:7c5:5229:2f1f with SMTP id af79cd13be357-7c5ba12daecmr1898157585a.5.1742819523042;
        Mon, 24 Mar 2025 05:32:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7DYTvtKn0P/kl/BHa8wQSRfuYtCao6wlu6Q9PsCZC1ThqSVz6wqDYT32DS0iIX8Uj/iHJxQ==
X-Received: by 2002:a05:620a:bcd:b0:7c5:5229:2f1f with SMTP id af79cd13be357-7c5ba12daecmr1898153785a.5.1742819522572;
        Mon, 24 Mar 2025 05:32:02 -0700 (PDT)
Received: from thinkpad2024 ([71.217.80.241])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b935f1c1sm501833285a.117.2025.03.24.05.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:32:02 -0700 (PDT)
Date: Mon, 24 Mar 2025 08:32:00 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Francesco Poli <invernomuto@paranoici.org>
Cc: linux-pm list <linux-pm@vger.kernel.org>,
	Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	John Kacur <jkacur@redhat.com>
Subject: Re: cpupower: systemd unit to run cpupower at boot
Message-ID: <Z-FQwMuVf_p7FoHn@thinkpad2024>
References: <20250322180357.1c17a180f1808533de77f186@paranoici.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322180357.1c17a180f1808533de77f186@paranoici.org>

On Sat, Mar 22, 2025 at 06:03:57PM +0100, Francesco Poli wrote:
> The attached files are tested on Debian GNU/Linux trixie (current

Would you please submit this in the form of a patch that we can apply
to the tree?

Please read (note the no attachments):
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

We do this to easily be able to comment in the mailing list and make it
easy for others to review.

> I took a look at how this is done in the [Arch Linux package] and I
> enhanced/modernized the systemd unit (the three files in Arch Linux are
> released under "GPL-2.0-or-later" terms).
Is this an issue Shuah?

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


