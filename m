Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 369104D095
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2019 16:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfFTOmL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Jun 2019 10:42:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49894 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfFTOmL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jun 2019 10:42:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 8B01A260676
Message-ID: <c6bc6c42a29d9cf996dc82880ee01b806b0705c2.camel@collabora.com>
Subject: Re: [PATCH 2/2] PM / devfreq: Sanitize prints
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     kernel@collabora.com, linux-pm@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Date:   Thu, 20 Jun 2019 11:41:58 -0300
In-Reply-To: <c053eea7-7c7f-a03a-0f09-83cd006a6a3a@samsung.com>
References: <20190605190053.19177-1-ezequiel@collabora.com>
         <CGME20190605190249epcas3p4c5e474328413c4a3944a1ae7cbd54c29@epcas3p4.samsung.com>
         <20190605190053.19177-2-ezequiel@collabora.com>
         <c053eea7-7c7f-a03a-0f09-83cd006a6a3a@samsung.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2019-06-20 at 16:23 +0900, Chanwoo Choi wrote:
> Hi,
> 
> Frankly, I don't like the existing 'DEVFREQ: ' prefix 
> because it is not used on all error log and it is not necessary.
> 
> Instead of this patch, I just prefer to delete the 'DEVFREQ: ' prefix
> 

Hm, I have to disagree. Having naked pr_{} with just the __func__
reducess logging consistency.

Thanks,
Ezequiel

