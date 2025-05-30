Return-Path: <linux-pm+bounces-27851-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A46B6AC8AE8
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 11:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668A11775B8
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 09:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427DD221FCD;
	Fri, 30 May 2025 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a7G9f4sB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A05B212B0A
	for <linux-pm@vger.kernel.org>; Fri, 30 May 2025 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597506; cv=none; b=X6n0zal8kBh31W1NaPMH2wo5guh1QVd0dFQel9Ez30BDyinSouhnpXSuZFPxJ28bp6Xb57F/xTvUSIaFi+iKkfepuLn1pM24zOigv/FIhSOsXICc+p4PnWXZVb6euBnMs97t6I89gBAZO+Xl1KcEHFwU3607MduaWmIcw/0IW64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597506; c=relaxed/simple;
	bh=zjDdMcJo7Ja3I/WBhXEJPi7Vf8GGUIfVIusJmH+sQRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JO3Scn60DQJG+epi51OQjHNL/HRJrrRQ0ijv/POTsmPh4eeq1HCh0QSMxvh7ZJoH5jxzS80VqWwgv0K7b8CHb5mNFm4lwlkNJ/1+kCLqLh9e6h1YqlJijqb6lPcvXMmt69hDQyrExSxwMfkkNOCBWj1cxZ+Cc/SRuqH6iehW+ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a7G9f4sB; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e75668006b9so1673880276.3
        for <linux-pm@vger.kernel.org>; Fri, 30 May 2025 02:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748597503; x=1749202303; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nl25XztXyY+91TCe2znVYLQyRFe3A02EIrzJh6x7GCo=;
        b=a7G9f4sBEY/YGgHiyzGfQtcl5WwSScKP5t262cYRu4yvgwRWO9SoLXiW9BrGywzoYP
         en2jB2ZZrJLDZXKGRBwjZKU2IzeMHq2Q2B/cdLNOS/g5z6WwCzJSBHmEXzF6F7gQcJAD
         qJvCEjWHh++ezR3sYbYR2h9+7UgMUgX0E2UXBJtvH52TziCwzxe/iYQ7PqWg/kJPHtn7
         WklZyDsFHsyOKXYknJx1Oa6RhetNNgCw0ZN4IjkRiw1MJUQsTDKtuLSakphPQ0em8wfi
         XfUfHrbAPLNhkEAldnqqsuDHaXRSV40TjZJops9Kgcb7Y6yfi/H6DTsOYZJYcKvgAMty
         2t1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597503; x=1749202303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nl25XztXyY+91TCe2znVYLQyRFe3A02EIrzJh6x7GCo=;
        b=iIeOWuaiPjmiuhWeE7kDJohsktnVxM8BnfZ34dZwhWvd1CQBqSWtZUemWw+uL/CyUW
         QAAOHhjQ+AWQFa0+Qvjug/Potr7UkpkU82d3ECLazH4tEzuh73nC4U7RKfaap1vwv889
         mHjstfJkg90XeLRubTDXT5k+hQXesoqKnLB9R6pecc0Ko+jZPwb1Ee0TjyFntyaHS58o
         kgAw9W7bgvWf1yUpYXmcxtVSz+r3oWhXoqNoHUHAOv34ncrbp9vEjVECog6F+h4FJFDs
         a8e0JmEIf8e/YlAd276ymRsB6yChh/u+uiATfPYw+Uj6gQhD4knkTfICm9svQ7ihYhUY
         Iz+w==
X-Forwarded-Encrypted: i=1; AJvYcCVylSTjzuK1NQfUjC37Sq80Tmh2CV8kBraASiV2+xroEEG9eKzkF5yEq7SoR87Xzq+vZT78MUhRPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGi3natnpV7RqZv7+/6sc/k8D9a92JA861KSf9EkpIE0OX1sqd
	SlJSYTGSdLqm4ePZoZOnFO6TJv8WZrRIS7ybhfPbeQUSht6m8gSF+M/TJnUt25aPFGUnLD75Tw7
	HykBR1/mFCzzNlNKCq1Aza4be1nh24C96HkQEE34REw==
X-Gm-Gg: ASbGncsK94TvZxky/mitAUGgNZ86kKLqiH7CL64ZjFdBJoqx5kRFG0xWaCiQNHh1NIO
	iDlv1Ls+7WR5NugMkOc1siMhz7TZIF3HBO75pVECakiqYui1I7xvH/DPQ9Q2M+fJXFA4RXeNiTr
	VzHEw31smIlrctaMveskjmTwT6FPYFdNtIACg8X6IcTuIF5XPPBXIsp18=
X-Google-Smtp-Source: AGHT+IH95Myawh7TbubfOpFEx22AdElqILjS1RFSDs37pv1ARTzzSoQyHKeRwabQyQ3x8Rz9anZLL/Bb5eyOoF6wyYc=
X-Received: by 2002:a05:6902:20c7:b0:e7d:c9f4:952b with SMTP id
 3f1490d57ef6-e7f81de0626mr3793584276.16.1748597503389; Fri, 30 May 2025
 02:31:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528-pmdomain-hierarchy-onecell-v2-0-7885ae45e59c@baylibre.com>
 <20250528-pmdomain-hierarchy-onecell-v2-1-7885ae45e59c@baylibre.com>
In-Reply-To: <20250528-pmdomain-hierarchy-onecell-v2-1-7885ae45e59c@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 30 May 2025 11:31:07 +0200
X-Gm-Features: AX0GCFsDY9QpXv-TDLaqMDwAZXQiaP-2ORBs2bXkP6yJWXm02HY-f6aS5ywCE0Y
Message-ID: <CAPDyKFqs=EuwzBodoh9-tnuDQP85bv3UnS5eoekCpjUbictfBQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/2] dt-bindings: power: add nexus map for power-domains
To: Kevin Hilman <khilman@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	arm-scmi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 May 2025 at 23:59, Kevin Hilman <khilman@baylibre.com> wrote:
>
> Add support for nexus map to be able to support hierarchical power
> domains for providers with #power-domain-cells > 0.
>
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/power/power-domain.yaml | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
> index 8fdb529d560b..9f099d326aee 100644
> --- a/Documentation/devicetree/bindings/power/power-domain.yaml
> +++ b/Documentation/devicetree/bindings/power/power-domain.yaml
> @@ -68,6 +68,15 @@ properties:
>        by the given provider should be subdomains of the domain specified
>        by this binding.
>
> +  power-domains-map:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Nexus node mapping property that establishes parent-child relationships
> +      for PM domains using the format defined in the Device Tree specification
> +      section 2.5.1. Each map entry consists of child domain specifier,
> +      parent phandle, and optional parent specifier arguments. This property
> +      is only supported for onecell providers (#power-domain-cells = 1).
> +
>  required:
>    - "#power-domain-cells"
>
> @@ -133,3 +142,29 @@ examples:
>              min-residency-us = <7000>;
>          };
>      };
> +
> +  - |
> +    // Example using power-domains-map for Nexus mapping
> +    main_pd: power-controller@12370000 {
> +        compatible = "foo,power-controller";
> +        reg = <0x12370000 0x1000>;
> +        #power-domain-cells = <0>;
> +    };
> +
> +    wkup_pd: power-controller@12380000 {
> +        compatible = "foo,power-controller";
> +        reg = <0x12380000 0x1000>;
> +        #power-domain-cells = <0>;
> +    };
> +
> +    scmi_pds protocol@11 {
> +        compatible = "arm,scmi-power-domain";
> +        reg = <0x11>;
> +        #power-domain-cells = <1>;
> +        power-domains-map = <15 &main_pd>,
> +                            <19 &wkup_pd>;
> +    };
> +
> +    // In this example using Nexus node mapping:
> +    // - Child domain 15 (scmi_pds 15) becomes a subdomain of main_pd
> +    // - Child domain 19 (scmi_pds 19) becomes a subdomain of wkup_pd
>
> --
> 2.49.0
>

