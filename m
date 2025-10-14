Return-Path: <linux-pm+bounces-36029-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5380FBD7677
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 07:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF05319A27E9
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 05:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365952874E1;
	Tue, 14 Oct 2025 05:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fBv2DrAf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0369152F88;
	Tue, 14 Oct 2025 05:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760419165; cv=none; b=WwXoJkHc+BMTNe9QLjI4j1gMdGRM7CHcaeXo+7EIrooRJU/xl46UkX7r8TxU26L++LvXpBKWtOitGbXIOYgrZGA6bxmLCVEaX38be+Vud2ejJ646fFvQCuEH3vZ5TSa+sgR9+Xh4aAwU+VaueWzLqXYj+Nup8LfQdv9l7UXc0MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760419165; c=relaxed/simple;
	bh=P11bZ2vFx2FlPsA2MVXbOOAQjNrO+j/jG6rcIlhajVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wy24l9Or2ieI5bl9wL1ZytEFTZ8ZegiTYgFJTeHT9fB2kJIkZGZGnfWZAT4sQsb7rLGwRJmX+k1oeIjp+ZQ3d4Y8w8JtLRWDFNT1hxzBiQ5kD4IfmXHS2tCmRsW7A1EdqqGhAt64dRibZtKy1eUEdeQ6rUG4NUulvBnIa9Chqo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fBv2DrAf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC47C4CEE7;
	Tue, 14 Oct 2025 05:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760419163;
	bh=P11bZ2vFx2FlPsA2MVXbOOAQjNrO+j/jG6rcIlhajVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fBv2DrAffOQ+nux4G/VHo3muAuwDukO2tau5mvLNfOs+5kp6u8zOQkPivRZMn7gxy
	 i7N/+8t/R01HdErs0rkjSCtPXCiHwdfmSEL+xs/bT+5YYz+h+4fDpEGo0e0e5kuFR9
	 cfUxvcO9aHReSeKRACtgW4iiSjhWcCUD1H4Vhscs=
Date: Tue, 14 Oct 2025 07:19:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
	bleung@chromium.org, akuchynski@chromium.org,
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/6] UCSI Power Supply Updates and Bug Fixes
Message-ID: <2025101433-yapping-landmark-6e0d@gregkh>
References: <20251007000007.3724229-1-jthies@google.com>
 <2025101316-rage-vegan-c380@gregkh>
 <CAMFSARdQCDcB=tAehoaNkjW+Ctp-ULiDTtyTSfMJX9whYaW7sQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMFSARdQCDcB=tAehoaNkjW+Ctp-ULiDTtyTSfMJX9whYaW7sQ@mail.gmail.com>

On Mon, Oct 13, 2025 at 01:59:23PM -0700, Jameson Thies wrote:
> Thank you for this feedback. The only patch here which is a clear bug
> fix is 5/6. Currently the driver reports 0.1A max current when nothing
> is connected on the port. I'll send that patch separately.

meta-comment, you lost all context here and I have no idea what you are
responding to, or what this is about :(

Remember, some of us get 1000+ emails a day to handle, context matters.

thanks,

greg k-h

