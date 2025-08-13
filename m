Return-Path: <linux-pm+bounces-32257-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A58B24757
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 12:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D23178F21
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 10:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD082F49E6;
	Wed, 13 Aug 2025 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwaeuRI5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CB22F3C36;
	Wed, 13 Aug 2025 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081047; cv=none; b=uPefsZySo4a2Pg+ja+y/UVQMXrxzRZklfbHCgOKpGztjTODec5B2yDDdtvqLk/EJbLxhD288RqbLbPI5D/veZim/t7xptJOH13p2xTnrl667U53VXnTbdEkQyKYVAMB9RlbQQ+0do6uxUw3dABK1k/huBDUF7nt83msHXV+okuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081047; c=relaxed/simple;
	bh=keXAvxTjtq/Pu5qvqTyCguHTkEQd5uS5Vby8kiHK3Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mLTaUY9wTwY/3SePdNLdSUBbZNs6zTOtUKgEmoh/5ujvy/lQOTinp6Yiua1ztOlPDeI/TY12eN0OwBOS6VbUkd0je0zOIf9+ylGipA7oW7DgorrTF6DdG2sJpISh1wW1Mv6NJ0SiVOrQ62GXP9bBStPAID7JW0RhhuO0C8ePPoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwaeuRI5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D6BC4CEEB;
	Wed, 13 Aug 2025 10:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755081047;
	bh=keXAvxTjtq/Pu5qvqTyCguHTkEQd5uS5Vby8kiHK3Qw=;
	h=From:To:Cc:Subject:Date:From;
	b=qwaeuRI5cFllfK1YEMjG8tRE+JmT9wuK0i84OIGoo/IZEvQ0ADRLEhQqAqZZFZ1+f
	 GUuezRluU4RJoQWNtl+Z+y0EtieNiNrkG+cjHeWGFt9MlI2XUYfzKUWq1HM4ker/xu
	 oIBWfIW54/uJ+zxp73o0aisZPV/MYKnSe9azNMPauNbg7IJjlN4FmxICTUOzJIVbKt
	 4BCqJwtS7Jv9licUxM23VqmjsGQG8r8gxfQYr8ahmGaOJaZDXsVYCipEie2Is//gW2
	 JlDKkJOHdyyffTPAOHQSkYo5l9P14Qg0cU0vib+MKX2peh7yUAdLhRTo4kKbVN31Nh
	 l3eDIwbiiqzMw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v1 0/3] cpuidle: governors: menu: A fix,
 a corner case adjustment and a cleanup
Date: Wed, 13 Aug 2025 12:21:18 +0200
Message-ID: <2804546.mvXUDI8C0e@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This series fixes a minor issue in the menu governor, related to violating
the PM QoS CPU latency limit in some rare cases, rearranges the code in
menu_select() to get rid of some excessive indentation, and adjusts the
handling of a corner case related to nohz_full CPUs.

Please refer to the changelogs of individual patches for details.

Thanks!




