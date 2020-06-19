Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C349201BD9
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jun 2020 22:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbgFSUCz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jun 2020 16:02:55 -0400
Received: from ms.lwn.net ([45.79.88.28]:55524 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbgFSUCy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Jun 2020 16:02:54 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 28CD52B8;
        Fri, 19 Jun 2020 20:02:54 +0000 (UTC)
Date:   Fri, 19 Jun 2020 14:02:53 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 02/22] docs: thermal: convert cpu-idle-cooling.rst to
 ReST
Message-ID: <20200619140253.148c3a8d@lwn.net>
In-Reply-To: <7640755514809a7b5fe2756f3702613865877dcb.1592203650.git.mchehab+huawei@kernel.org>
References: <cover.1592203650.git.mchehab+huawei@kernel.org>
        <7640755514809a7b5fe2756f3702613865877dcb.1592203650.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 15 Jun 2020 08:50:07 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Despite being named with .rst extension, this file doesn't
> match the ReST standard. It actually causes a crash at
> Sphinx:
> 
> 	Sphinx parallel build error:
> 	docutils.utils.SystemMessage: /devel/v4l/docs/Documentation/driver-api/thermal/cpu-idle-cooling.rst:69: (SEVERE/4) Unexpected section title.
> 
> Add needed markups for it to be properly parsed.
> 
> While here, add it to the thermal index.rst.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---

Applied (though I took out the line about adding it to index.rst since
this patch doesn't do that...)

Thanks,

jon
