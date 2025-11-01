Return-Path: <linux-pm+bounces-37239-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D73A3C274E3
	for <lists+linux-pm@lfdr.de>; Sat, 01 Nov 2025 01:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F927189FBCB
	for <lists+linux-pm@lfdr.de>; Sat,  1 Nov 2025 00:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5300E1E89C;
	Sat,  1 Nov 2025 00:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMSQjqkY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0911397;
	Sat,  1 Nov 2025 00:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761958101; cv=none; b=u23AI5O56cvOr1UpcyGt/uJtY5OlJMvuNHY2Gm4FElX9nhHZ61DF76ZDBecXtafN6oU9i124kO5Q+aZtGHOGl9DzO4KERY+b6oLh7TZGzBrdeD/8qn947Fp3PYN5egqv/Jv86mTRvEkGHW7sQ9/ypOEMB6Mr/lW6nKbWVotWav4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761958101; c=relaxed/simple;
	bh=gVmU7p20Dkh1MkTMXJqDbhSOU2knZn8d816HpufhXIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lvkq/Cyy495/2LNqLWg3fTZ5uZMVrNqGLHGpfOREZCLQ6/bSg6tbjBLRUNE8ibB4zqjC4lb9rnX5INo/bfGfJeYmrGTguH8R8dR3DNkwi9qIWiLWk3gJQygK8xw+RqcBzKP04NSSOfjysMIPN/VjcHZO/ljdtp5lXc59d1DwWE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMSQjqkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96016C4CEE7;
	Sat,  1 Nov 2025 00:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761958100;
	bh=gVmU7p20Dkh1MkTMXJqDbhSOU2knZn8d816HpufhXIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DMSQjqkYOAHSkJKNWA52qpYoV0G4DyrvMV9pByA4RzPCRg06Z7Zu9qTfdijtCEYC4
	 v4d2g3eCTvv0DaGkWqETKObLr2WwD57MXZmVuKGeu7rJVV1+Dy5AzX5zr7zW9PFzvI
	 oKp3msAcVQFURtirJ6AcKjWO/4sQ7pgk6cIj4TzfUeB3fn7lQk19ZQRv2vBo3LQfgu
	 /lKfMZ0OT4a9HhXMmaAq5ngaVA9ojNVRs/QYdxj6sbsmiTjX8ZtfyMYP+PPYTUOtY5
	 aTIBDJFhLaacxGBQqhPxERF6wTGIfJB+LCk1eaITcideupmOTbn/5vgMwznQ+AvIKc
	 UHwA8WRya/RRQ==
Date: Fri, 31 Oct 2025 14:48:19 -1000
From: Tejun Heo <tj@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH PM/for-6.19] freezer: Clarify that only cgroup1 freezer
 uses PM freezer
Message-ID: <aQVY0yrigjd4kj7C@slm.duckdns.org>
References: <aPZ3q6Hm865NicBC@slm.duckdns.org>
 <CAJZ5v0gPNwrKXNg1Ng6bJ5B99PEDNhdh2YrfvbcpXc4CjLq0ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gPNwrKXNg1Ng6bJ5B99PEDNhdh2YrfvbcpXc4CjLq0ww@mail.gmail.com>

On Thu, Oct 30, 2025 at 08:11:51PM +0100, Rafael J. Wysocki wrote:
> I gather that this is for me to pick up, so applied.

Right, I should have been clearer. Thanks!

-- 
tejun

