Return-Path: <linux-pm+bounces-34007-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FAFB4610E
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 19:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3645A06B81
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 17:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DBE2741C3;
	Fri,  5 Sep 2025 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1Doe/PO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161473191DB
	for <linux-pm@vger.kernel.org>; Fri,  5 Sep 2025 17:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094704; cv=none; b=cdk5F9vZ2APQ7rmO9TL8E90SZP1cWIVgymAIq8n3jhQdhMmFskaAKk3CLjZT/H/1wUISzLatw10C3eRtS8be5NW9mhtXdBAx3pb5YUlyK6faSlKMorbMlMZV6kF49ayKGr46/X8sf8SZYE5R/+3HGNmMbTLM4VOFG+PfgaeHqMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094704; c=relaxed/simple;
	bh=WA1/qpWiONQ6ZeqY6L1/qu1W5betsE/u3Wz1RhtlcFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GEgde3nT3X+wwSch8UbpJpAl397dLBT6+ZD03/DnSX/qLb0r+7+Fvse+17IKOt1INDqssqwu7w6zZ05cJPqldj3v/G+pCVcbx1BirjSvB5sSeJbIMID+coWo6X/ymiAE9ptujJEjT9OszRzIh61W415dV/NC6T4ExibM4KkleaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1Doe/PO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544CFC4CEF1;
	Fri,  5 Sep 2025 17:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757094703;
	bh=WA1/qpWiONQ6ZeqY6L1/qu1W5betsE/u3Wz1RhtlcFA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=O1Doe/POv/o02clXOPG0Mvuyn4ilqUrxD7JQ0UXKZpNL7UmO27iJUZKLoNx/BYJAG
	 tcOJ8zlTcnRh6bzoNU6ZPMTzby7WV/E6yzaCKtAPAeq5R2wX9UKu/bF6uQhf0C4YNH
	 gCQU/rSEJg5PPmuvOGohYx6iH3gL3VN5f7dII7xEMDBV1V7fS3WhyKqK70OqrukAR4
	 TVyhXWNap/hbxZDN8sQyp7qdLRe3QXLZtjbAD+/j/38pu191pTRLd8XtAykVdcNTWl
	 6ZVAVCmgnxGSCDAqSA48XF3VlVn3gXz7I+4/fSkM7lORmsQ2kcRZAEQjXNl6iXaBYN
	 9Q3AMP43MlsvQ==
Message-ID: <cc7e3318-78a1-4219-a4eb-48e769afc6d4@kernel.org>
Date: Fri, 5 Sep 2025 12:51:42 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Subject: [PATCH 1/1] x86: Fix spurious 8042 for Mechrevo
 Yilong15Pro
To: aprilgrimoire <aprilgrimoire@proton.me>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <WO4-1V8LhkguyJ12_oK3K7dgEjZwM31XRoXJEbZa-sLbqL85Lmc7iqi_3dCpyyFKsuDSlMj5_Kg-r5iZX4rxeHqsF9T6jXkE7RaGZDrbDhE=@proton.me>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <WO4-1V8LhkguyJ12_oK3K7dgEjZwM31XRoXJEbZa-sLbqL85Lmc7iqi_3dCpyyFKsuDSlMj5_Kg-r5iZX4rxeHqsF9T6jXkE7RaGZDrbDhE=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/5/2025 3:30 AM, aprilgrimoire wrote:
>  From d82abe97c5696e22eb24c7eabe641432446da8cf Mon Sep 17 00:00:00 2001From: April Grimoire <AprilGrimoire@proton.me>
> Date: Fri, 5 Sep 2025 16:24:33 +0800
> Subject: [PATCH] Subject: [PATCH 1/1] x86: Fix spurious 8042 for Mechrevo
>   Yilong15Pro
> 
> The firmware of Mechrevo Yilong15Pro emits a spurious keyboard interrupt on
> events including closing the lid. When a user closes the lid on an already
> suspended system this causes the system to wake up.
> Add Mechrevo Yilong15Pro Series (GM5HG7A) to the list of quirk
> spurious_8042 to workaround this issue.
> 
> Link: https://lore.kernel.org/linux-pm/6ww4uu6Gl4F5n6VY5dl1ufASfKzs4DhMxAN8BuqUpCoqU3PQukVSVSBCl_lKIzkQ-S8kt1acPd58eyolhkWN32lMLFj4ViI0Tdu2jwhnYZ8=@proton.me/
> 
> Signed-off-by: April Grimoire <aprilgrimoire@proton.me>
> ---

Three comments.

1) The subject line is really messed up.
2) This needs to be submitted to platform-x86 mailing list instead.

3) It doesn't apply to the -fixes branch for platform-x86.  You'll need 
to rebase it.

❯ git checkout platform-x86/fixes
Note: switching to 'platform-x86/fixes'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

   git switch -c <new-branch-name>

Or undo this operation with:

   git switch -

Turn off this advice by setting config variable advice.detachedHead to false

HEAD is now at aa28991fd5dc4 platform/x86/intel: power-domains: Use 
topology_logical_package_id() for package ID
❯ b4 shazam -sl 
https://lore.kernel.org/linux-pm/WO4-1V8LhkguyJ12_oK3K7dgEjZwM31XRoXJEbZa-sLbqL85Lmc7iqi_3dCpyyFKsuDSlMj5_Kg-r5iZX4rxeHqsF9T6jXkE7RaGZDrbDhE=@proton.me/
Grabbing thread from 
lore.kernel.org/all/WO4-1V8LhkguyJ12_oK3K7dgEjZwM31XRoXJEbZa-sLbqL85Lmc7iqi_3dCpyyFKsuDSlMj5_Kg-r5iZX4rxeHqsF9T6jXkE7RaGZDrbDhE%3D@proton.me/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 1 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Checking attestation on all messages, may take a moment...
---
   ✓ [PATCH] Subject: [PATCH 1/1] x86: Fix spurious 8042 for Mechrevo 
Yilong15Pro
     + Link: 
https://lore.kernel.org/r/WO4-1V8LhkguyJ12_oK3K7dgEjZwM31XRoXJEbZa-sLbqL85Lmc7iqi_3dCpyyFKsuDSlMj5_Kg-r5iZX4rxeHqsF9T6jXkE7RaGZDrbDhE=@proton.me
     + Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
   ---
   ✓ Signed: DKIM/proton.me
---
Total patches: 1
---
Applying: Subject: [PATCH 1/1] x86: Fix spurious 8042 for Mechrevo 
Yilong15Pro
Patch failed at 0001 Subject: [PATCH 1/1] x86: Fix spurious 8042 for 
Mechrevo Yilong15Pro
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
error: corrupt patch at line 10
hint: Use 'git am --show-current-patch=diff' to see the failed patch

>   drivers/platform/x86/amd/pmc/pmc-quirks.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
> index 18fb44139d..4d0a38e06f 100644
> --- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
> +++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
> @@ -239,6 +239,14 @@ static const struct dmi_system_id fwbug_list[] = {
>              DMI_MATCH(DMI_BOARD_NAME, "WUJIE14-GX4HRXL"),
>          }
>      },
> +   {
> +       .ident = "MECHREVO Yilong15Pro Series GM5HG7A",
> +       .driver_data = &quirk_spurious_8042,
> +       .matches = {
> +           DMI_MATCH(DMI_SYS_VENDOR, "MECHREVO"),
> +           DMI_MATCH(DMI_PRODUCT_NAME, "Yilong15Pro Series GM5HG7A"),
> +       }
> +   },
>      /* https://bugzilla.kernel.org/show_bug.cgi?id=220116 */
>      {
>          .ident = "PCSpecialist Lafite Pro V 14M",
> --
> 2.49.1


