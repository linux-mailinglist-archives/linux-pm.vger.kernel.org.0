Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A370827963C
	for <lists+linux-pm@lfdr.de>; Sat, 26 Sep 2020 04:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgIZCap (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 22:30:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727495AbgIZCap (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Sep 2020 22:30:45 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C829F206E5;
        Sat, 26 Sep 2020 02:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601087445;
        bh=ttpTgYzXopAatsApc0pGrkNrc9iSWLibOUMl6nLpCJE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=y1jXQpuDd0jp9Ec6IFYi0brKIM0XUtmCpXsk0ITqdRHlP+LaKzSKvRh1RO6/2iPOW
         L6hKWKKt+wMj6ALUkB4BY/ZNtFB0Rwnc33pXgI28e1GMCmcBCymDQnTLuMpnzObyDV
         p2zUS2l1M7JRlZBJokjdGrrWE80mAf98i26M/2bI=
Date:   Sat, 26 Sep 2020 11:30:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Renninger <trenn@suse.de>
Cc:     linux-pm@vger.kernel.org, rafael@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: tools/bootconfig: Create missing directories in Makefile
 install object if needed
Message-Id: <20200926113041.d0ce430c3b3e4c76cf4e857a@kernel.org>
In-Reply-To: <2482827.XuMzNZMSYQ@c100>
References: <2482827.XuMzNZMSYQ@c100>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 25 Sep 2020 17:09:09 +0200
Thomas Renninger <trenn@suse.de> wrote:

> Signed-off-by: Thomas Renninger <trenn@suse.de>

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> ---
>  tools/bootconfig/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/tools/bootconfig/Makefile
> +++ b/tools/bootconfig/Makefile
> @@ -24,7 +24,7 @@
>  	./test-bootconfig.sh $(OUTPUT)
>  
>  install: $(ALL_PROGRAMS)
> -	install $(OUTPUT)bootconfig $(DESTDIR)$(bindir)
> +	install -D $(OUTPUT)bootconfig $(DESTDIR)$(bindir)/bootconfig
>  
>  clean:
>  	$(RM) -f $(OUTPUT)*.o $(ALL_PROGRAMS)
> 
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
