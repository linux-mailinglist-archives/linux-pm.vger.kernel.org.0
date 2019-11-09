Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01750F5E15
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2019 09:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfKIIig (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Nov 2019 03:38:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfKIIif (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 9 Nov 2019 03:38:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81FDC21848;
        Sat,  9 Nov 2019 08:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573288715;
        bh=a7fLBawWFKeIVLIDVhLlPxmFBOKSQ/6SGIvmDoVf9WE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TJcXI23TSGt7vNQeUcx+mR35bw4xs2R6FKNy2HWZN8lhwCbKfWO14t2Snftt+25tu
         Y7820CVV+XB0aAmQulQwtgf+bUgGOycyA3OWgHIfWQsUip67P2aNCfw4fVqdb7DcL6
         eY3bOTNPMcMvPQgyaPHnjxV5iocQQVTZGKb9F7OY=
Date:   Sat, 9 Nov 2019 09:38:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Elliot Berman <eberman@codeaurora.org>
Cc:     sre@kernel.org, tkjos@google.com, tsoni@codeaurora.org,
        rananta@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] reboot: Export reboot_mode
Message-ID: <20191109083832.GA1289838@kroah.com>
References: <1573256452-14838-1-git-send-email-eberman@codeaurora.org>
 <1573256452-14838-2-git-send-email-eberman@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573256452-14838-2-git-send-email-eberman@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 08, 2019 at 03:40:51PM -0800, Elliot Berman wrote:
> Export reboot_mode to support kernel modules wishing to modify reboot_mode.
> 
> Signed-off-by: Elliot Berman <eberman@codeaurora.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
