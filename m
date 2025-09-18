Return-Path: <linux-pm+bounces-34995-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD1BB86C9B
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 21:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C831CC405F
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 19:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709333054ED;
	Thu, 18 Sep 2025 19:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJyoza8v"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AEE2D77E2;
	Thu, 18 Sep 2025 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225424; cv=none; b=YUNFTFpe13TnxYB27A21mZmnHKv5UFwEbPC/TY0z0mNq7vx3YnJndD3MR1/z4MXREK3XZu99e9HLaIcbdXdI78SR/bWeV0Ji3BPYHrTiKMS3u6CgdsGm0dlNxAJJGKTyyyn4MaIiKl2O1nUhC3g4PwTxTRTeD897fi5NEcbOLEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225424; c=relaxed/simple;
	bh=/JWO9VL4ExF1e1iYCU3E9KNX+wlOgloizir5GTZfG6o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ttRtGJwglxRdU27EtKgUL22R5Z3yO9D0xqa7VdBLPTTnwf62F1WipL2EKvot1e5xs7B7sBDcujD2lACj+NPTLfHb9QxHPJfik6gt3O+AlkT55Ezj6uTgICWQbABvkXvqHOGNTeCeP3HwQKsQjCUkmuXFbYYrLuyFIV5Zoyc6k1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJyoza8v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98420C4CEE7;
	Thu, 18 Sep 2025 19:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758225423;
	bh=/JWO9VL4ExF1e1iYCU3E9KNX+wlOgloizir5GTZfG6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tJyoza8vWP/EdLAEENSzo2uWtvKDVNVpN3f7nmQYItwJ5GrIhTCNmG+eXw3/+CXpa
	 +DScb66DzLLI8WdZLZbA++did6skO2sEuzileMQIpt6iCtdXkTVTW685d3bzidNqon
	 VtVWC3oxH/HEC7ejd8c72mwpgE6C/8hWF3R6ZRDeeTxLwITpMcNoebV7jK5y3vgWUd
	 2sBZ8foMhoT68Yj0UHMlYkXGwqiLItNidKphwd6ws3l/jLINWxdPh1B4ztSG4UwHjS
	 fcbkPYBPzhL9C6alcGKzheFW18xgpnjacrXTkP7sN4gtjFxEonWUh3nnYIlHz+MIVK
	 2v+s/NyI3UYhw==
Date: Thu, 18 Sep 2025 14:57:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>,
	"open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	AceLan Kao <acelan.kao@canonical.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Merthan =?utf-8?Q?Karaka=C5=9F?= <m3rthn.k@gmail.com>,
	Eric Naim <dnaim@cachyos.org>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v8 2/4] scsi: Add PM_EVENT_POWEROFF into suspend callbacks
Message-ID: <20250918195702.GA1918855@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918034427.3226217-3-superm1@kernel.org>

On Wed, Sep 17, 2025 at 10:44:25PM -0500, Mario Limonciello (AMD) wrote:
> When the ACPI core uses hibernation callbacks for shutdown drivers
> will receive PM_EVENT_POWEROFF and should handle it the same as
> PM_EVENT_HIBERNATE would have been used.

Apparently ACPI hibernation means PM_EVENT_POWEROFF, and something
else means PM_EVENT_HIBERNATE?  That's confusing to me at least.

> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Tested-by: Eric Naim <dnaim@cachyos.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> v8:
>  * Break up series to 3 parts
>  * Pick up tag
> v5:
>  * Re-order
> v4:
>  * https://lore.kernel.org/linux-pci/20250616175019.3471583-1-superm1@kernel.org/
> ---
>  drivers/scsi/mesh.c | 1 +
>  drivers/scsi/stex.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/scsi/mesh.c b/drivers/scsi/mesh.c
> index 1c15cac41d80..768b85eecc8f 100644
> --- a/drivers/scsi/mesh.c
> +++ b/drivers/scsi/mesh.c
> @@ -1762,6 +1762,7 @@ static int mesh_suspend(struct macio_dev *mdev, pm_message_t mesg)
>  	case PM_EVENT_SUSPEND:
>  	case PM_EVENT_HIBERNATE:
>  	case PM_EVENT_FREEZE:
> +	case PM_EVENT_POWEROFF:
>  		break;
>  	default:
>  		return 0;
> diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
> index 63ed7f9aaa93..ee9372e1f7f0 100644
> --- a/drivers/scsi/stex.c
> +++ b/drivers/scsi/stex.c
> @@ -1965,6 +1965,7 @@ static int stex_choice_sleep_mic(struct st_hba *hba, pm_message_t state)
>  	case PM_EVENT_SUSPEND:
>  		return ST_S3;
>  	case PM_EVENT_HIBERNATE:
> +	case PM_EVENT_POWEROFF:
>  		hba->msi_lock = 0;
>  		return ST_S4;
>  	default:
> -- 
> 2.51.0
> 

