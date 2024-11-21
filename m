Return-Path: <linux-pm+bounces-17922-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC4D9D534B
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 20:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240F91F224E9
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 19:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AF21B0F0C;
	Thu, 21 Nov 2024 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wbmpHOd1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B76200A3;
	Thu, 21 Nov 2024 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732216308; cv=none; b=Pos0LTM6KjE0aZNTX/03kzeRE0Kow2iHac2JK041HQlWKDxHusVObLOG4sauw1A14qHBunxX/n4w0DKYqReal8A3KlXIMWTi918cOEQDoSd9H+babTNuC9MG4tUv962NqAR8eFLhWPVAB8Q3UKdnLAM2wkkH7mj9Z2m/zz4G6pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732216308; c=relaxed/simple;
	bh=uSVFyxZWPtpNONJ7K33n6OGLQ4wpa7KotjalYqksq3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6lpwVgSl5XgTKTufqfGcY7BDCNhz3mD2q7BypGbGuwALOqRAB9EgiO2ylod1NegodUdlPHzGQnK/ENSi6QFvDGNQCpRQCyhOMIINAviUynWZInJkXQVH+Zn9QkuIRfAdyMvRIL/c8Lqoy+s5D9nOS98+cz8YShR506qDABJW6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wbmpHOd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71324C4CECD;
	Thu, 21 Nov 2024 19:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732216308;
	bh=uSVFyxZWPtpNONJ7K33n6OGLQ4wpa7KotjalYqksq3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wbmpHOd11qlBzCNWIm2Lg67fyEyhWoTTt5StpQZAE40M+n6U1oDNAaC23oDdYkG7C
	 fLFjE63lXEVaYO24K3JrMh2QSxbxA1xwmgc3B40ghuuBRwXzKzA8+ZC2xOtYgelG2y
	 AcVN2J8vdeiii/Ivuq5iADA7UaoQRxA88M3XwhOo=
Date: Thu, 21 Nov 2024 20:09:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: duanchenghao <duanchenghao@kylinos.cn>
Cc: stern@rowland.harvard.edu, saranya.gopal@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org, niko.mauno@vaisala.com, pavel@ucw.cz,
	rafael@kernel.org, stanley_chang@realtek.com, tj@kernel.org,
	xiehongyu1@kylinos.cn, xy521521@gmail.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4] USB: Fix the issue of task recovery failure caused by
 USB status when S4 wakes up
Message-ID: <2024112109-joystick-landlord-5957@gregkh>
References: <e795d88afb2b485fab97e2be7759664e823fbfad.camel@kylinos.cn>
 <20241024024038.26157-1-duanchenghao@kylinos.cn>
 <2024102432-conjoined-skylight-33f1@gregkh>
 <8aff9a5acbd21d7bd08b80e02ef2b34f2028cedf.camel@kylinos.cn>
 <2024102911-mooned-precise-f526@gregkh>
 <31be22e3ee6633e0753a717c7c0994802662a39d.camel@kylinos.cn>
 <2239f30a31d48b326c1b11a2f551439652781419.camel@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2239f30a31d48b326c1b11a2f551439652781419.camel@kylinos.cn>

On Wed, Nov 06, 2024 at 09:29:15AM +0800, duanchenghao wrote:
> Hi Greg k-h & Alan,
> 
> Excuse me, both of you. I've noticed that you haven't replied to the
> emails for quite some time, which prompted me to send this one. I'd
> like to inquire if the proposal in the current email is feasible and if
> it can be integrated into the community.

Sorry, I missed this in the last round of patch reviews.  I'll queue it
up after 6.13-rc1 is out as the merge window is closed for adding new
stuff to my trees.

thanks,

greg k-h

