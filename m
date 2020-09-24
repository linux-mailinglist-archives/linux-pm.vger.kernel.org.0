Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7370277277
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 15:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgIXNfe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 09:35:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbgIXNfd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Sep 2020 09:35:33 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89ACC239CF;
        Thu, 24 Sep 2020 13:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600954533;
        bh=jNYB+k706dvukRlfQCKIIeYhSWdl/6xpkY0GwY25mZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YtsVSiNv8kv/pgfi/D1vADNUaNbpXNnTvbIHhUqxXYOkJi878WzcX2cV755gn+MjU
         +sYN9x8a8ZoIsJ1FaD5eA7rJjAwpkquFqEspHXhbm1GWMGU48E5BUOlYwhuZedK5US
         Gcp/PMzn6VJ7EV33ZdT2ZwfClGPl6T5czAyLLtaE=
Date:   Thu, 24 Sep 2020 15:35:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 5.10
Message-ID: <20200924133517.GA719043@kroah.com>
References: <20200924130242.24867-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924130242.24867-1-georgi.djakov@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 24, 2020 at 04:02:42PM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with the interconnect changes for the 5.10-rc1
> merge window. It contains both core changes and new drivers. More details
> are available in the signed tag.
> 
> All patches have been in linux-next without any reported issues. Please
> pull into char-misc-next.
> 
> Thanks,
> Georgi
> 
> The following changes since commit 91e045b93db79a2ef66e045ad0d1f8f9d348e1f4:
> 
>   interconnect: qcom: Fix small BW votes being truncated to zero (2020-09-04 00:07:12 +0300)
> 
> are available in the Git repository at:
> 
>   https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.10-rc1


Pulled and pushed out, thanks.

greg k-h
