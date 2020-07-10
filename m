Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B08221B411
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 13:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgGJLfE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 07:35:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgGJLfE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Jul 2020 07:35:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54CE42077D;
        Fri, 10 Jul 2020 11:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594380903;
        bh=PlfcgJIeoyJntUfEcAlADHn23e3ubuPer0DgiV9OeCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XRqBEco3dBJtllbPeh2QEsoI3r66tPqDy1zvS/NgGfWCTHO41pUGlCF0O/NTGj8ci
         iJBt05rTpTA3Ku32kAcQvN1CRTwtzO1y29H/9L2jbGtZHgXWxqYeHWJZa0lGOSJTAi
         y21yJVGILyy/0n9FeSzSkerO2uWYTpuvSETQk2Hw=
Date:   Fri, 10 Jul 2020 13:35:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fei1 Jiang =?utf-8?B?6JKL6aOe?= <jiangfei1@xiaomi.com>
Cc:     Qiwu Huang <yanziily@gmail.com>, "sre@kernel.org" <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?6buE5YW25q2m?= <huangqiwu@xiaomi.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbRXh0ZXJuYWwgTWFp?=
 =?utf-8?B?bF1SZTogW1BBVENIIDIvNV0gcG93ZXI=?= =?utf-8?Q?=3A?= supply: core:
 add wireless charger adapter type property
Message-ID: <20200710113508.GA1238203@kroah.com>
References: <20200710084841.1933254-1-yanziily@gmail.com>
 <20200710084841.1933254-2-yanziily@gmail.com>
 <20200710100037.GB1197607@kroah.com>
 <1594380492771.51916@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1594380492771.51916@xiaomi.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 10, 2020 at 11:28:13AM +0000, Fei1 Jiang 蒋飞 wrote:
> #/******本邮件及其附件含有小米公司的保密信息，仅限于发送给上面地址中列出的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本邮件！ This e-mail and its attachments contain confidential information from XIAOMI, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender by phone or email immediately and delete it!******/#

Now deleted :(
