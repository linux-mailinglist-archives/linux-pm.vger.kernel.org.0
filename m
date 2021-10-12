Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8CA42A5AE
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 15:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbhJLN35 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Oct 2021 09:29:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236368AbhJLN35 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 Oct 2021 09:29:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AD8B60EB6;
        Tue, 12 Oct 2021 13:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634045275;
        bh=ZFiJ6UcV5HwXuat8mqBIVOr429AuPEOWFSQ/txgPsRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2BQwIUah65fQnGFT5tXduy8nfkUaDmCR5mwtZLWokn0kG9PPo3PcB7SrUPLKtMomh
         /N178Hs30/LL1+vepEMPf6oogNlbrpf4Ci8O1z4eOzHECZpzvC3wj8HQzR1FwFMcBA
         nVVByNk6LF+/INMm6+uwM51dG/nBN2HMWAnkQ810=
Date:   Tue, 12 Oct 2021 15:27:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
Cc:     linux-pm@vger.kernel.org, rafael@kernel.org, khilman@kernel.org,
        ulf.hansson@linaro.org, pavel@ucw.cz
Subject: Re: [PATCH] PM: domains: using dev_err_probe() to simplify error
 handling
Message-ID: <YWWNWawA857Y0TW2@kroah.com>
References: <YWWIw1hAQAYjjrfK@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YWWIw1hAQAYjjrfK@fedora>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 12, 2021 at 10:08:19AM -0300, Maíra Canal wrote:
> Replacing dev_err() for dev_err_probe() in order to reduce code size and
> uniform error handling.
> 
> Signed-off-by: Maíra Canal <maira.canal@usp.br>
> ---
>  drivers/base/power/domain.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 5db704f02e71..e7701b79494a 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2249,10 +2249,8 @@ int of_genpd_add_provider_simple(struct device_node *np,
>  	if (genpd->set_performance_state) {
>  		ret = dev_pm_opp_of_add_table(&genpd->dev);
>  		if (ret) {
> -			if (ret != -EPROBE_DEFER)
> -				dev_err(&genpd->dev, "Failed to add OPP table: %d\n",
> +			return dev_err_probe(&genpd->dev, ret, "Failed to add OPP table: %d\n",
>  					ret);

But this isn't a probe function of a driver, shouldn't that be the only
place you use dev_err_probe()?

thanks,

greg k-h
