Return-Path: <linux-pm+bounces-4-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DC37F22A4
	for <lists+linux-pm@lfdr.de>; Tue, 21 Nov 2023 01:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91AB8B216F3
	for <lists+linux-pm@lfdr.de>; Tue, 21 Nov 2023 00:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49A915B6;
	Tue, 21 Nov 2023 00:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xWqEWGLc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9504517CA
	for <linux-pm@vger.kernel.org>; Tue, 21 Nov 2023 00:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40B4C433C7;
	Tue, 21 Nov 2023 00:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700528215;
	bh=WydedWHI5hgSzmjYaAgFcEvQrWisnvd0Tah1sl3VwoE=;
	h=Date:From:To:Subject:From;
	b=xWqEWGLcLZXz1KWeC4J5A1Ig7lzDguSYM4ky6RFUSfFbn46V3MxOm/fxp2KlEHuR+
	 /mQrzO7S/pJs0n/pB0NG6vs/0kQoqGuafhQCACrlMJaDUozGVOQii4hBYGzK6yQV3z
	 Tikj/ApPdntonPkFkGrryqDC0kyooreY7BnX4/cs=
Date: Mon, 20 Nov 2023 19:56:54 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-pm@vger.kernel.org
Subject: PSA: this list has moved to new vger infra (no action required)
Message-ID: <20231120-meek-hamster-of-proficiency-00899f@nitro>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

This list has been migrated to new vger infrastructure. No action is required
on your part and there should be no change in how you interact with this list.

This message acts as a verification test that the archives are properly
updating.

If something isn't working or looking right, please reach out to
helpdesk@kernel.org.

Best regards,
-K

