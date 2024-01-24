Return-Path: <linux-pm+bounces-2656-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F16CA83A43B
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 09:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917551F27DE6
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 08:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC473F514;
	Wed, 24 Jan 2024 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=severnouse.com header.i=@severnouse.com header.b="E049nDc/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.severnouse.com (mail.severnouse.com [141.95.160.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FC017580
	for <linux-pm@vger.kernel.org>; Wed, 24 Jan 2024 08:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.95.160.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085400; cv=none; b=XYBnEUBhn+dou90GJjXocVjpgNE+0NjdZaVry97ey4LXAmOnR3BHVxsF4MxK5Pl+XpDS2RSX2zGYPlRD6gUvIHC6t99wJGPQ7eD/xe9MpWxCHh9oJd9wp6eKe57+bf+/YbNv4zH8I6R3Mnlrs7D8SY0b3MU1LZy8Gcz+S8WHI6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085400; c=relaxed/simple;
	bh=waaYxUsyRtmB2zEBuWcqRuRHSoYd8sJFCtgHO/3AHKE=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=q7AThyDkDPHqZNrIVCS8hpPgYJ9iAnuIxkil53zkFU0t190US3hZxIkZs/2L85RTlOFaEd6LgV63FdfNsQ7cA9qj62db/+ae3KVgYWBWewNpNjmaaOS8N2J/i7PmUfSbTsJKRCLl9bH4YCIlWCVx+LL3DkGYwLj5shE31FjO99E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=severnouse.com; spf=pass smtp.mailfrom=severnouse.com; dkim=pass (2048-bit key) header.d=severnouse.com header.i=@severnouse.com header.b=E049nDc/; arc=none smtp.client-ip=141.95.160.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=severnouse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=severnouse.com
Received: by mail.severnouse.com (Postfix, from userid 1002)
	id A0263A2D09; Wed, 24 Jan 2024 08:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=severnouse.com;
	s=mail; t=1706085387;
	bh=waaYxUsyRtmB2zEBuWcqRuRHSoYd8sJFCtgHO/3AHKE=;
	h=Date:From:To:Subject:From;
	b=E049nDc/WW5P5p4Kr4o2Qb9pF7wR/zSuqt0saLQrvPMLHKIafxh6CVAIwtNUt7bqf
	 VbiI6ONFwSRaAL/FBPZs2jNGw0fy8iVE5BeHWQp4UTGKjDf9F9F0NlWCGf1WmJ17/L
	 uV81Rj0sE6hfzuWussW+490DVrucd0LqSmzPouaZwEEovCYwEI1rGQD43EyltfnQnT
	 yXF9wF3IYroqgUrSrVASIhM14VMv/kV4BXckH6kVIt6kVpOAirEeiqfBqbH6jidc42
	 doVUPDOMPcx5pxSI7w+/ZoZC4aivVvjn4aNfCPXaqOUEI2Q+eNH+1WtA+4X1PQoQoD
	 7jOnxneQCjPNQ==
Received: by mail.severnouse.com for <linux-pm@vger.kernel.org>; Wed, 24 Jan 2024 08:36:10 GMT
Message-ID: <20240124074500-0.1.bm.ozaj.0.qmcigobqt6@severnouse.com>
Date: Wed, 24 Jan 2024 08:36:10 GMT
From: "Ray Galt" <ray.galt@severnouse.com>
To: <linux-pm@vger.kernel.org>
Subject: Meeting with the Development Team
X-Mailer: mail.severnouse.com
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I would like to reach out to the decision-maker in the IT environment wit=
hin your company.

We are a well-established digital agency in the European market. Our solu=
tions eliminate the need to build and maintain in-house IT and programmin=
g departments, hire interface designers, or employ user experience specia=
lists.

We take responsibility for IT functions while simultaneously reducing the=
 costs of maintenance. We provide support that ensures access to high-qua=
lity specialists and continuous maintenance of efficient hardware and sof=
tware infrastructure.

Companies that thrive are those that leverage market opportunities faster=
 than their competitors. Guided by this principle, we support gaining a c=
ompetitive advantage by providing comprehensive IT support.

May I present what we can do for you?


Best regards
Ray Galt

