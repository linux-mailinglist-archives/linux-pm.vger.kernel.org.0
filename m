Return-Path: <linux-pm+bounces-26337-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CF8A9FDC3
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 01:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B74185A7CCA
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 23:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28F51DB958;
	Mon, 28 Apr 2025 23:31:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CE71D6DAA
	for <linux-pm@vger.kernel.org>; Mon, 28 Apr 2025 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745883116; cv=none; b=jKlJyNLE2o+JijhUZc15ctPNWbkVow1AkpgGrrlExTE1UKO9VXBPL2lDHWOmVPZ/u9smrjR3Im6wN2xPyyM9AF1GVyQgUuSYYbLaoaZQBKU6lfiJS4UWqqkYrpiKtn+l/A3EBxytGGPrLfZTjUJDKLoo8OJJgICthQQF5davOEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745883116; c=relaxed/simple;
	bh=UKidmeQNgxvJOFLUPTWmBzK+brEapLnEDFFLc4ivPUo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gHr2m7UX8+S1FlmKXI3ATrsePcqQyTyZawryccdS8dQbd6hUTVmqKACcWJAiYLTejEJjYAVDMCp20QXXKiPwrIbXKzAomuSacZjfZ0WbLvI/FL09zc8rNw2+k0GWqUFYB9iLbm1i4ZGigaADdMUzEoPeizEZQgWpEacBwGnagYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133E1C4CEEA;
	Mon, 28 Apr 2025 23:31:56 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 6BD09180757; Tue, 29 Apr 2025 01:31:54 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
 Jelle van der Waa <jvanderwaa@redhat.com>
Cc: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250414131840.382756-1-jvanderwaa@redhat.com>
References: <20250414131840.382756-1-jvanderwaa@redhat.com>
Subject: Re: [PATCH v2 0/1] power: supply: support charge_types in the
 extensions API
Message-Id: <174588311442.37089.2061504743621562611.b4-ty@collabora.com>
Date: Tue, 29 Apr 2025 01:31:54 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 14 Apr 2025 15:18:39 +0200, Jelle van der Waa wrote:
> The goal of this patch is to make it possible for the ideapad-laptop
> driver to move from its custom conservation_mode sysfs attribute to the
> standardised charge_types sysfs attribute with a power_supply extension.
> Along with other laptop models which support an end charge threshold
> which limits it to a fixed value such as some Toshiba and LG models.
> 
> User space, in this case UPower would then be detect 'Long Life' as
> charge_types option and set it.
> 
> [...]

Applied, thanks!

[1/1] power: supply: support charge_types in extensions
      commit: c1f7375a246e5f810191a6c3031d2fa2b80e9f5e

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


