Return-Path: <linux-pm+bounces-27087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DE2AB5A8B
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 18:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411413A9342
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 16:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934C91D63EE;
	Tue, 13 May 2025 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b="S/qsIU59"
X-Original-To: linux-pm@vger.kernel.org
Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78461AAE2E
	for <linux-pm@vger.kernel.org>; Tue, 13 May 2025 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747155049; cv=none; b=OeenSUu51T/kHmFQ9UQPqP5EQ6RglTMVdZDuG+yIeayZ/5Mre6xv09gHwkMGa3SzhRMkHaPp7JbYPEAgzQRp6zTs8TJbjFfqED/Wzn3QqHJJyO+1I+f8+oGofBvDpF1FiHWXv6T76960n4nKneb3yha5MV0wPr1swVBsC95Qc90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747155049; c=relaxed/simple;
	bh=IzdlC4/KrVhkgauAg3rQi23U6iKWVZOnRnDkfzVxxBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R4BRI0vesFpdKksWKBLPctTOPbP4WnqpMWDVBvkDfwOi+rCcsz8eDotDINIQ3EPK8KltgFizoLJU7wZzXFXUFihcpWw2wYIlrgKhv0/gAw6ZodErbtPY/9UFse6Jm4Qm3/JG0tqqouyzn8UguyCM4cpHiirVRKh/oHukamhp4Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org; spf=pass smtp.mailfrom=paranoici.org; dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b=S/qsIU59; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paranoici.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
	s=stigmate; t=1747154678;
	bh=IzdlC4/KrVhkgauAg3rQi23U6iKWVZOnRnDkfzVxxBk=;
	h=From:To:Cc:Subject:Date:From;
	b=S/qsIU59xnJ/FiALuZdGuxtoyT41dlJJl6MNEyBePd4sSAV7Ky/wogId6OvfyFYFl
	 0vU5e5ekyuRCDRxOcBKSE4MtumjvBWqpZiziT6vRMbjwyaA6RI7J7AVXf+7ytJveT+
	 y1YrudKSlt5DmPfSbLL5Z2KL7sJ7uKH4G+lWbsj4=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4Zxj4Q4hfRz6vNm;
	Tue, 13 May 2025 16:44:38 +0000 (UTC)
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: invernomuto@paranoici.org) by localhost (Postfix) with ESMTPSA id 4Zxj4Q4LhXz6vML;
	Tue, 13 May 2025 16:44:38 +0000 (UTC)
Received: from frx by crunch with local (Exim 4.98.2)
	(envelope-from <invernomuto@paranoici.org>)
	id 1uEsk9-00000000Gkt-1U0N;
	Tue, 13 May 2025 18:44:37 +0200
From: "Francesco Poli (wintermute)" <invernomuto@paranoici.org>
To: linux-pm list <linux-pm@vger.kernel.org>
Cc: Francesco Poli <invernomuto@paranoici.org>,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Justin Forbes <jforbes@redhat.com>
Subject: [PATCH 0/3] cpupower: fixes for cpupower.service
Date: Tue, 13 May 2025 18:29:30 +0200
Message-ID: <20250513163937.61062-2-invernomuto@paranoici.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hello!

I prepared a patch series to address the issues reported about my
previous patch by Thorsten Leemhuis.

The patch series has been created against the tip of the
'origin/cpupower' git branch.
I hope it can be applied soon, if you agree with the fixes.

Thanks for your time!
Bye.

